import express from 'express';
import { createFund, isCreateFundError } from './actions/createFund';

const webApp = express();
const port = Number(process.env.PORT ?? '3000');

webApp.get('/createFund', async (req, res, next) => {
  const organizationId = Number(req.query.organizationId);
  const name = String(req.query.name);

  try {
    const logger = await createFund({ organizationId, name });
    res.setHeader('Content-Type', 'text/plain');
    res.send(logger.logs.join('\n'));
  } catch (error) {
    if (isCreateFundError(error)) {
      res.setHeader('Content-Type', 'text/plain');
      res.send(error.logger.logs.join('\n') + '\n\n' + String(error.error));
    } else {
      next(error);
    }
  }
});

webApp.get('/', (req, res) => {
  res.setHeader('Content-Type', 'text/html');
  res.send(`
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>db bootstrapping tool</title>
  </head>
  <body>
    <h1>Setup fund</h1>
    <form action="/createFund" method="GET">
      <p>
        <label>
          Organization ID:
          <input name="organizationId" type="number">
        </label>
      </p>
      <p>
        <label>
          Fund name:
          <input name="name" type="text">
        </label>
      </p>
      <p>
        <input type="submit">
      </p>
    </form>
  </body>
</html>  
  `);
});

webApp.listen(port, () => {
  console.log(`listening on :${port}`);
});
