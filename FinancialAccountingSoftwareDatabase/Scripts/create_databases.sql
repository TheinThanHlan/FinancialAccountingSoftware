
--coa = chart of accounts
create Table COA(
	id INTEGER PRIMARY KEY autoincrement,
	code INTEGER Unique not null,
	account TEXT UNIQUE NOT Null,
	isIncreaseInDebit Integer Not Null,
	isHidden INTEGER default 0

);
--#-#

create index coa_code_account_index on COA(code,account);
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
