import { insert } from '../db/insert';

export type RecordTypeChildrenNth = {
  key: 'children_nth';
  type: 'number';
};

export type RecordTypeGender = {
  key: 'gender';
  type: 'string';
};

export type RecordType = RecordTypeChildrenNth | RecordTypeGender;

export const insertRecordTypeWrapped = insert<RecordType>(
  'INSERT INTO `record_types` (`key`, `type`) VALUES (?, ?)',
  recordType => [recordType.key, recordType.type]
);
