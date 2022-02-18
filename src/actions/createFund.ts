import mysql from 'mysql2/promise';
import {
  DATABASE_HOST,
  DATABASE_NAME,
  DATABASE_PASSWORD,
  DATABASE_PORT,
  DATABASE_USERNAME,
} from '../credentials';
import { api } from '../lib/api';
import { Fund } from '../lib/entities/Fund';
import { Logger } from '../Logger';

export type CreateFundError = {
  kind: 'CreateFundError';
  logger: Logger;
  error: unknown;
};

export function isCreateFundError(error: any): error is CreateFundError {
  return (
    typeof error === 'object' &&
    error !== null &&
    'kind' in error &&
    error.kind === 'CreateFundError'
  );
}

export async function createFund(
  fund: Pick<Fund, 'organizationId' | 'name'>
): Promise<Logger> {
  // create the connection to database
  const mysqlConnection = await mysql.createConnection({
    host: DATABASE_HOST,
    port: Number(DATABASE_PORT),
    user: DATABASE_USERNAME,
    password: DATABASE_PASSWORD,
    database: DATABASE_NAME,
  });
  const logger = new Logger();
  const {
    insertFund,
    insertFundCriteria,
    insertRecordType,
    insertFundConfig,
    updateIsConfiguredFundConfig,
  } = api(mysqlConnection, logger);

  logger.log('          START TRANSACTION');
  await mysqlConnection.beginTransaction();

  try {
    const fundResult = await insertFund({
      organizationId: fund.organizationId,
      name: fund.name,
      externalLinkText: 'sample external link text',
    });

    await insertFundCriteria({
      fundId: fundResult.rowId,
      description: 'sample description',
    });

    await insertRecordType({
      key: 'children_nth',
      type: 'number',
    });

    await insertRecordType({
      key: 'gender',
      type: 'string',
    });

    const fundConfigResult = await insertFundConfig({
      fundId: fundResult.rowId,
      implementationId: 1,
      isConfigured: 0,
    });

    await updateIsConfiguredFundConfig(fundConfigResult.rowId, {
      isConfigured: 1,
    });

    logger.log('          COMMIT');
    await mysqlConnection.commit();
  } catch (error) {
    logger.log('          ROLLBACK');
    await mysqlConnection.rollback();
    mysqlConnection.end();

    const err: CreateFundError = {
      kind: 'CreateFundError',
      logger,
      error,
    };
    throw err;
  }

  return logger;
}
