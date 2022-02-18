import mysql from 'mysql2/promise';

type DBInsertResult = {
  rowId: number;
  query: string;
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
  insertObject: T
) => Promise<DBInsertResult> {
  return async function (mysqlConnection, insertObject) {
    const sql = mysqlConnection.format(
      preparedStatement,
      extractParams(insertObject)
    );
    const [row]: [mysql.ResultSetHeader, unknown] = await mysqlConnection.query(
      sql
    );

    return {
      rowId: row.insertId,
      query: sql,
    };
  };
}

export function logInsertResults(result: DBInsertResult): void {
  const prefix = ('#' + result.rowId).padStart(8, ' ');
  console.log(`${prefix}: ${result.query}`);
}
