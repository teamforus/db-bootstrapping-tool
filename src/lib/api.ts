import mysql from 'mysql2/promise';
import { Logger } from '../Logger';
import { InsertFunc } from './db/insert';
import { UpdateFunc } from './db/update';
import { Fund, insertFundWrapped } from './entities/Fund';
import {
  FundConfig,
  FundConfigUpdateIsConfigured,
  insertFundConfigWrapped,
  updateIsConfiguredFundConfigWrapped,
} from './entities/FundConfig';
import {
  FundCriteria,
  insertFundCriteriaWrapped,
} from './entities/FundCriteria';
import { FundFormula, insertFundFormulaWrapped } from './entities/FundFormulas';
import { insertRecordTypeWrapped, RecordType } from './entities/RecordType';

export function api(
  connection: mysql.Connection,
  logger: Logger
): {
  insertFund: InsertFunc<Fund>;
  insertFundConfig: InsertFunc<FundConfig>;
  insertFundCriteria: InsertFunc<FundCriteria>;
  insertFundFormula: InsertFunc<FundFormula>;
  insertRecordType: InsertFunc<RecordType>;
  updateIsConfiguredFundConfig: UpdateFunc<FundConfigUpdateIsConfigured>;
} {
  return {
    insertFund: insertFundWrapped(connection, logger),
    insertFundConfig: insertFundConfigWrapped(connection, logger),
    insertFundCriteria: insertFundCriteriaWrapped(connection, logger),
    insertFundFormula: insertFundFormulaWrapped(connection, logger),
    insertRecordType: insertRecordTypeWrapped(connection, logger),
    updateIsConfiguredFundConfig: updateIsConfiguredFundConfigWrapped(
      connection,
      logger
    ),
  };
}
