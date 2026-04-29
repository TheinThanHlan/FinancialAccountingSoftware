create Table AccountType(
	id INTEGER PRIMARY KEY,
  name Text unique not null,
  start_with INTEGER not null,
  isIncreaseInDebit boolean not null
);

insert into AccountType values 
(1,'assets',1,1), 
(2,'liabilities',2,0), 
(3,'equity',3,0), 
(4,'revenue',4,0), 
(5,'expenses',5,0),
(6,'contra assets',6,0), 
(7,'contra liabilities',6,1), 
(8,'contra equity',6,1), 
(9,'contra revenue',6,1), 
(10,'contra expenses',6,1);


--coa = chart of accounts
create Table COA(
	id INTEGER PRIMARY KEY autoincrement,
	code TEXT Unique not null,
	account TEXT UNIQUE NOT Null,
	accountTypeId Integer not null References AccountType(id)
	--isHidden INTEGER default 0

);
--#-#

--create index coa_code_account_index on COA(code,account);
--#-#


create Table SourceDocument(
	id INTEGER Primary Key autoincrement,
	documentLocation TEXT
);
--#-#


create Table SourceDocumentImage(
	id INTEGER Primary Key autoincrement,
	sourceDocumentId Integer not null References SourceDocument(id),
	imageLocation TEXT not null UNIQUE
);


--#-#
create Table SourceDocumentPdf(
	id INTEGER Primary Key autoincrement,
	sourceDocumentId Integer not null References SourceDocument(id),
	pdfLocation TEXT not null UNIQUE
);


--#-#

--drop Table GeneralJournal;
create Table GeneralJournal(
	id INTEGER PRIMARY KEY autoincrement,
	description TEXT,
	journalDate INTEGER,
	createdAt INTEGER  default (strftime('%s','now')*1000),
	sourceDocumentId INTEGER  References SourceDocument(id)
);


--#-#
create Table JournalEntry(
	id INTEGER Primary Key autoincrement,
	generalJournalId INTEGER not null References GeneralJournal(id),
	affectedAccountId INTEGER not null REFERENCES COA(id),
	isDebit INTEGER not null,
	amount REAL not null
);
--#-#
