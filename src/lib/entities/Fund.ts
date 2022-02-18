import { insert } from '../db/insert';

export type Fund = {
  organizationId: number;
  name: string;
  externalLinkText: string;
};

export const insertFundWrapped = insert<Fund>(
  'INSERT INTO `funds` (`organization_id`, `name`, `external_link_text`) VALUES (?, ?, ?)',
  fund => [fund.organizationId, fund.name, fund.externalLinkText]
);
