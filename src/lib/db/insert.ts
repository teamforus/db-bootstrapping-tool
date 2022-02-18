import mysql from 'mysql2/promise';

type DBInsertResult = {
  rowId: number;
};

/**
 * @param preparedStatement prepared SQL statement with the placeholders
 * @param extractParams function to extract placeholders to respective positions
 * @returns async function to insert object in the database
 */
export function insert<T>(
  preparedStatement: string,
  extractParams: (obj: T) => Array<unknown>
): (
  mysqlConnection: mysql.Connection,
  logger: (...msgs: unknown[]) => void,
  insertObject: T
) => Promise<DBInsertResult> {
  return async function (mysqlConnection, logger, insertObject) {
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
      logger(`!!FAILED: ${sql}`);
      throw error;
    }

    const prefix = ('#' + row.insertId).padStart(8, ' ');
    logger(`${prefix}: ${sql}`);

    return { rowId: row.insertId };
  };
}
