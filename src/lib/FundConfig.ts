import { insert } from './db/insert';
import { update } from './db/update';

type FundConfig = {
  fundId: number;
  implementationId: number;
  isConfigured: number;
};

export const insertFundConfig = insert<FundConfig>(
  'INSERT INTO `fund_configs` (`fund_id`, `implementation_id`, `is_configured`) VALUES (?, ?, ?)',
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
  fundConfig => [fundConfig.isConfigured]
);
