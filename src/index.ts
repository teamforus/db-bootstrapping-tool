import mysql from 'mysql2/promise';
import { insertFund } from './lib/Fund';
import { insertFundCriteria } from './lib/FundCriteria';
import { logInsertResults } from './lib/db/insert';
import { insertRecordType } from './lib/RecordType';
import {
  insertFundConfig,
  updateIsConfiguredFundConfig,
} from './lib/FundConfig';
import { logUpdateResults } from './lib/db/update';

(async () => {
  // create the connection to database
  const mysqlConnection = await mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'example',
    database: 'demoForus',
  });

  console.log('          START TRANSACTION');
  await mysqlConnection.beginTransaction();

  try {
    const fundResult = await insertFund(mysqlConnection, {
      organizationId: 1,
      name: 'test',
      externalLinkText: 'sample external link text',
    });
    logInsertResults(fundResult);

    const fundCriteriaResult = await insertFundCriteria(mysqlConnection, {
      fundId: fundResult.rowId,
      description: 'sample description',
    });
    logInsertResults(fundCriteriaResult);

    const recordTypeChildrenResult = await insertRecordType(mysqlConnection, {
      key: 'children_nth',
      type: 'number',
    });
    logInsertResults(recordTypeChildrenResult);

    const recordTypeGenderResult = await insertRecordType(mysqlConnection, {
      key: 'gender',
      type: 'string',
    });
    logInsertResults(recordTypeGenderResult);

    const fundConfigResult = await insertFundConfig(mysqlConnection, {
      fundId: fundResult.rowId,
      implementationId: 1,
      isConfigured: 0,
    });
    logInsertResults(fundConfigResult);

    const updateFundConfigResult = await updateIsConfiguredFundConfig(
      mysqlConnection,
      fundConfigResult.rowId,
      { isConfigured: 1 }
    );
    logUpdateResults(updateFundConfigResult);

    console.log('          COMMIT');
    await mysqlConnection.commit();
  } catch (error) {
    console.log('          ROLLBACK');
    await mysqlConnection.rollback();
    mysqlConnection.end();
    throw error;
  }

  mysqlConnection.end();
})();
