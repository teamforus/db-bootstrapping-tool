import { insert } from './db/insert';

export type FundFormula = {
  fundId: number;
  type: 'empty' | 'multiply' | 'fixed';
  amount: number;
};

export const insertFundFormula = insert<FundFormula>(
  'INSERT INTO `fund_formula` (`fund_id`, `type`, `amount`) VALUES (?, ?, ?)',
  fundFormula => [fundFormula.fundId, fundFormula.type, fundFormula.amount]
);
