import { insert } from './db/insert';
import { update } from './db/update';

export type FundConfig = {
  fundId: number;
  implementationId: number;
  isConfigured: number;
};

export const insertFundConfig = insert<FundConfig>(
  'INSERT INTO `fund_configs` (`fund_id`, `implementation_id`, `is_configured`) VALUES (?, ?, ?)',
  // as values in statement are ordered we need this function to order parameters for the sql statement
  fundConfig => [
    fundConfig.fundId,
    fundConfig.implementationId,
    fundConfig.isConfigured,
  ]
);

export const updateIsConfiguredFundConfig = update<
  Pick<FundConfig, 'isConfigured'>
>(
  'UPDATE `fund_configs` SET `is_configured` = ? WHERE `id` = ?',
  // here is only 1 parameters, for update statement row id will be added as the last one
  fundConfig => [fundConfig.isConfigured]
);
