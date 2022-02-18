import mysql from 'mysql2/promise';
import { Logger } from '../../Logger';

export type UpdateFunc<T> = (
  updateRowId: number,
  updateObject: T
) => Promise<void>;

/**
 * @param preparedStatement prepared SQL statement with the placeholders
 * @param extractParams function to extract placeholders to respective positions
 * @returns async function to update object in the database
 */
// there is annotated example of use at ../FundConfig.ts
export const update =
  <T>(
    preparedStatement: string,
    extractParams: (obj: T) => Array<unknown>
  ): ((mysqlConnection: mysql.Connection, logger: Logger) => UpdateFunc<T>) =>
  (mysqlConnection, logger) =>
  async (updateRowId, updateObject) => {
    const sql = mysqlConnection.format(preparedStatement, [
      ...extractParams(updateObject),
      // would be the last param
      updateRowId,
    ]);

    try {
      await mysqlConnection.query(sql);
    } catch (error) {
      logger.log(`    failed: ${sql}`);
      throw error;
    }

    logger.log(`          ${sql}`);
  };
