import mysql from 'mysql2/promise';

/**
 * @param preparedStatement prepared SQL statement with the placeholders
 * @param extractParams function to extract placeholders to respective positions
 * @returns async function to update object in the database
 */
// there is annotated example of use at ../FundConfig.ts
export function update<T>(
  preparedStatement: string,
  extractParams: (obj: T) => Array<unknown>
): (
  mysqlConnection: mysql.Connection,
  logger: (...msgs: unknown[]) => void,
  updateRowId: number,
  updateObject: T
) => Promise<void> {
  return async function (mysqlConnection, logger, updateRowId, updateObject) {
    const sql = mysqlConnection.format(preparedStatement, [
      ...extractParams(updateObject),
      // would be the last param
      updateRowId,
    ]);

    try {
      await mysqlConnection.query(sql);
    } catch (error) {
      logger(`    failed: ${sql}`);
      throw error;
    }

    logger(`          ${sql}`);
  };
}
