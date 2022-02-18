import { insert } from '../db/insert';

export type FundCriteria = {
  fundId: number;
  description: string;
};

export const insertFundCriteriaWrapped = insert<FundCriteria>(
  'INSERT INTO `fund_criteria` (`fund_id`, `description`) VALUES (?, ?)',
  fundCriteria => [fundCriteria.fundId, fundCriteria.description]
);
