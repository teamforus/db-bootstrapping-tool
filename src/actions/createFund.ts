import mysql from 'mysql2/promise';
import {
  DATABASE_HOST,
  DATABASE_NAME,
  DATABASE_PASSWORD,
  DATABASE_PORT,
  DATABASE_USERNAME,
} from '../credentials';
import { Fund, insertFund } from '../lib/Fund';
import {
  insertFundConfig,
  updateIsConfiguredFundConfig,
} from '../lib/FundConfig';
import { insertFundCriteria } from '../lib/FundCriteria';
import { insertRecordType } from '../lib/RecordType';
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
  const logger = new Logger();
  // create the connection to database
  const mysqlConnection = await mysql.createConnection({
    host: DATABASE_HOST,
    port: Number(DATABASE_PORT),
    user: DATABASE_USERNAME,
    password: DATABASE_PASSWORD,
    database: DATABASE_NAME,
  });

  logger.log('          START TRANSACTION');
  await mysqlConnection.beginTransaction();

  try {
    const fundResult = await insertFund(mysqlConnection, logger.log, {
      organizationId: fund.organizationId,
      name: fund.name,
      externalLinkText: 'sample external link text',
    });

    await insertFundCriteria(mysqlConnection, logger.log, {
      fundId: fundResult.rowId,
      description: 'sample description',
    });

    await insertRecordType(mysqlConnection, logger.log, {
      key: 'children_nth',
      type: 'number',
    });

    await insertRecordType(mysqlConnection, logger.log, {
      key: 'gender',
      type: 'string',
    });

    const fundConfigResult = await insertFundConfig(
      mysqlConnection,
      logger.log,
      {
        fundId: fundResult.rowId,
        implementationId: 1,
        isConfigured: 0,
      }
    );

    await updateIsConfiguredFundConfig(
      mysqlConnection,
      logger.log,
      fundConfigResult.rowId,
      { isConfigured: 1 }
    );

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
