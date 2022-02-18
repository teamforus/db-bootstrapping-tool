import mysql from 'mysql2/promise';

type DBUpdateResult = {
  rowId: number;
  query: string;
};

/**
 * @param preparedStatement prepared SQL statement with the placeholders
 * @param extractParams function to extract placeholders to respective positions
 * @returns async function to update object in the database
 */
export function update<T>(
  preparedStatement: string,
  extractParams: (obj: T) => Array<unknown>
): (
  mysqlConnection: mysql.Connection,
  updateRowId: number,
  updateObject: T
) => Promise<DBUpdateResult> {
  return async function (mysqlConnection, updateRowId, updateObject) {
    const sql = mysqlConnection.format(preparedStatement, [
      ...extractParams(updateObject),
      // would be the last param
      updateRowId,
    ]);
    const [row]: [mysql.ResultSetHeader, unknown] = await mysqlConnection.query(
      sql
    );

    return {
      rowId: row.insertId,
      query: sql,
    };
  };
}

export function logUpdateResults(result: DBUpdateResult): void {
  console.log(`          ${result.query}`);
}
