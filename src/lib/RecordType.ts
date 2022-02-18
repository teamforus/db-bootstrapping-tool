import { insert } from './db/insert';

type RecordTypeChildrenNth = {
  key: 'children_nth';
  type: 'number';
};

type RecordTypeGender = {
  key: 'gender';
  type: 'string';
};

type RecordType = RecordTypeChildrenNth | RecordTypeGender;

export const insertRecordType = insert<RecordType>(
  'INSERT INTO `record_types` (`key`, `type`) VALUES (?, ?)',
  recordType => [recordType.key, recordType.type]
);
