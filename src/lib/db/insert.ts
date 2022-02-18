import mysql from 'mysql2/promise';
import { Logger } from '../../Logger';

type DBInsertResult = {
  rowId: number;
};

export type InsertFunc<T> = (insertObject: T) => Promise<DBInsertResult>;

/**
 * @param preparedStatement prepared SQL statement with the placeholders
 * @param extractParams function to extract placeholders to respective positions
 * @returns async function to insert object in the database
 */
// there is annotated example of use at ../FundConfig.ts
export const insert =
  <T>(
    preparedStatement: string,
    extractParams: (obj: T) => Array<unknown>
  ): ((mysqlConnection: mysql.Connection, logger: Logger) => InsertFunc<T>) =>
  (mysqlConnection, logger) =>
  async insertObject => {
    const sql = mysqlConnection.format(
      preparedStatement,
      extractParams(insertObject)
    );

    let row: mysql.ResultSetHeader;
    try {
      const result: [mysql.ResultSetHeader, unknown] =
        await mysqlConnection.query(sql);
      row = result[0];
    } catch (error) {
      logger.log(`!!FAILED: ${sql}`);
      throw error;
    }

    const prefix = ('#' + row.insertId).padStart(8, ' ');
    logger.log(`${prefix}: ${sql}`);

    return { rowId: row.insertId };
  };
