import { insert } from './db/insert';

type FundCriteria = {
  fundId: number;
  description: string;
};

export const insertFundCriteria = insert<FundCriteria>(
  'INSERT INTO `fund_criteria` (`fund_id`, `description`) VALUES (?, ?)',
  fundCriteria => [fundCriteria.fundId, fundCriteria.description]
);
