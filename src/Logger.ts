export class Logger {
  logs: string[] = [];

  constructor() {}

  log = (...params: any[]) => {
    this.logs.push(String(...params));
    console.log(...params);
  };
}
