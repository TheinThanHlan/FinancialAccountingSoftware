--inserting chart of accounts
--#-#
--insert into COA(code,account,accountTypeId) values
--('1','Cash',1),
--('2','Accounts payable',2),
--('3','Common stock',3),
--('4','Sales',4),
--('5','Cost of goods sold',5);





-- 1. Chart of Accounts
INSERT INTO COA (code, account, accountTypeId) VALUES 
('1010', 'Cash', 1), ('1020', 'Accounts Receivable', 1), ('1200', 'Office Equipment', 1),
('1201', 'Accumulated Depreciation', 6), ('2010', 'Accounts Payable', 2), ('3010', 'Common Stock', 3),
('4010', 'Service Revenue', 4), ('5010', 'Rent Expense', 5), ('5020', 'Utilities Expense', 5);

-- 2 & 3. General Journal and Journal Entries for April 2026
INSERT INTO GeneralJournal (id, description, journalDate, sourceDocumentId) VALUES (1, 'Initial Investment', 1775001600000, NULL);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (1, 1, 1, 50000.00);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (1, 6, 0, 50000.00);

INSERT INTO GeneralJournal (id, description, journalDate, sourceDocumentId) VALUES (2, 'Prepaid Rent for Month', 1775001600000, NULL);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (2, 8, 1, 1500.00);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (2, 1, 0, 1500.00);

INSERT INTO GeneralJournal (id, description, journalDate, sourceDocumentId) VALUES (3, 'Purchased Equipment on Credit', 1775174400000, NULL);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (3, 3, 1, 8000.00);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (3, 5, 0, 8000.00);

INSERT INTO GeneralJournal (id, description, journalDate, sourceDocumentId) VALUES (4, 'Service Revenue - Cash', 1775347200000, NULL);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (4, 1, 1, 2400.00);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (4, 7, 0, 2400.00);

INSERT INTO GeneralJournal (id, description, journalDate, sourceDocumentId) VALUES (5, 'Service Revenue - On Account', 1775606400000, NULL);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (5, 2, 1, 3500.00);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (5, 7, 0, 3500.00);

INSERT INTO GeneralJournal (id, description, journalDate, sourceDocumentId) VALUES (6, 'Paid Utilities', 1775865600000, NULL);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (6, 9, 1, 300.00);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (6, 1, 0, 300.00);

INSERT INTO GeneralJournal (id, description, journalDate, sourceDocumentId) VALUES (7, 'Partial Payment to AP', 1776211200000, NULL);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (7, 5, 1, 2000.00);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (7, 1, 0, 2000.00);

INSERT INTO GeneralJournal (id, description, journalDate, sourceDocumentId) VALUES (8, 'Collection of AR', 1776556800000, NULL);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (8, 1, 1, 1500.00);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (8, 2, 0, 1500.00);

INSERT INTO GeneralJournal (id, description, journalDate, sourceDocumentId) VALUES (9, 'Service Revenue - Cash', 1776816000000, NULL);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (9, 1, 1, 1200.00);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (9, 7, 0, 1200.00);

INSERT INTO GeneralJournal (id, description, journalDate, sourceDocumentId) VALUES (10, 'Office Supplies Expense', 1777075200000, NULL);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (10, 9, 1, 150.00);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (10, 1, 0, 150.00);

INSERT INTO GeneralJournal (id, description, journalDate, sourceDocumentId) VALUES (11, 'Service Revenue - On Account', 1777334400000, NULL);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (11, 2, 1, 4000.00);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (11, 7, 0, 4000.00);

INSERT INTO GeneralJournal (id, description, journalDate, sourceDocumentId) VALUES (12, 'Month-end Salary Payment', 1777507200000, NULL);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (12, 9, 1, 3000.00);
INSERT INTO JournalEntry (generalJournalId, affectedAccountId, isDebit, amount) VALUES (12, 1, 0, 3000.00);

--#-#


--(1010,'Main Checking Account',1),
--(1020,'Payroll Account",1),
--(1050,"Accounts Receivable",1),
--(1100,"Inventory",1),
--(1150,"Supplies",1),
--(1200,"Prepaid Insurance",1),
--(1210,"Prepaid Rent",1),
--(1300,"Land",1),
--(1310,"Buildings",1),
--(1315,"Accumulated Depreciation - Buildings",0),
--(1320,"Office Equipment",1),
--(1325,"Accumulated Depreciation - Office Equipment",0),
--(1330,"Vehicles",1),
--(1335,"Accumulated Depreciation - Vehicles",0),
--(1400,"Goodwill",1),
--(2010,"Accrued Expenses Payable",0),
--(2020,"Salaries Payable",0),
--(2030,"Taxes Payable (VAT)",0),
--(2050,"Unearned Revenue",0),
--(2100,"Short-Term Notes Payable",0),
--(2110,"Current Portion of Long-Term Debt",0),
--(2200,"Long-Term Bank Loan",0),
--(2210,"Bonds Payable",0),
--(3000,"Common Stock",0),
--(3010,"Preferred Stock",0),
--(3020,"Additional Paid-in Capital",0),
--(3050,"Retained Earnings",0),
--(3060,"Dividends",1),
--(3100,"Owner's Capital",0),
--(3110,"Owner's Drawings",1),
--(4000,"Sales Revenue",0),
--(4010,"Service Revenue",0),
--(4020,"Interest Revenue",0),
--(4030,"Rent Revenue",0),
--(5000,"Cost of Goods Sold",1),
--(5100,"Salaries Expense",1),
--(5110,"Wages Expense",1),
--(5120,"Commissions Expense",1),
--(5200,"Rent Expense",1),
--(5210,"Utilities Expense",1),
--(5220,"Telephone Expense",1),
--(5230,"Internet Expense",1),
--(5300,"Depreciation Expense",1),
--(5310,"Amortization Expense",1),
--(5400,"Advertising Expense",1),
--(5410,"Marketing Expense",1),
--(5500,"Office Supplies Expense",1),
--(5510,"Travel Expense",1),
--(5520,"Meals and Entertainment Expense",1),
--(5600,"Insurance Expense",1),
--(5610,"Repairs and Maintenance Expense",1),
--(5700,"Bank Fees Expense",1),
--(5710,"Interest Expense",1),
--(5800,"Legal and Professional Fees",1),
--(5810,"Miscellaneous Expense",1),
--(6000,"Income Tax Expense",1);
--#-#
