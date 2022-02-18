import { insert } from './db/insert';

type Fund = {
  organizationId: number;
  name: string;
  externalLinkText: string;
};

export const insertFund = insert<Fund>(
  'INSERT INTO `funds` (`organization_id`, `name`, `external_link_text`) VALUES (?, ?, ?)',
  fund => [fund.organizationId, fund.name, fund.externalLinkText]
);
