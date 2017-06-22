-- ----------------------------------------------------------------------
-- Instructions:
-- ----------------------------------------------------------------------
-- The two scripts contain spooling commands, which is why there
-- isn't a spooling command in this script. When you run this file
-- you first connect to the Oracle database with this syntax:
--
--   sqlplus student/student@xe
--
-- Then, you call this script with the following syntax:
--
--   sql> @apply_oracle_lab11.sql
--
-- ----------------------------------------------------------------------

-- Run the prior lab script.
@/home/student/Data/cit225/oracle/lab11/apply_oracle_lab11.sql

SPOOL apply_oracle_lab12.log

-- Create the following CALENDAR table as per the specification.
SELECT 'STEP #1' AS "CODE" FROM dual;

CREATE TABLE calendar
( calendar_id			NUMBER
, calendar_name			VARCHAR2(10)	CONSTRAINT nn_calendar_1 NOT NULL
, calendar_short_name		VARCHAR2(3)	CONSTRAINT nn_calendar_2 NOT NULL
, start_date			DATE		CONSTRAINT nn_calendar_3 NOT NULL
, end_date			DATE		CONSTRAINT nn_calendar_4 NOT NULL
, created_by			NUMBER		
, creation_date			DATE		CONSTRAINT nn_calendat_5 NOT NULL
, last_updated_by		NUMBER
, lat_update_date		DATE		CONSTRAINT nn_calendar_6 NOT NULL
, CONSTRAINT pk_calendar_1	PRIMARY KEY(calendar_id)
, CONSTRAINT fk_calendar_1	FOREIGN KEY(created_by) 	REFERENCES system_user(system_user_id)
, CONSTRAINT fk_calendar_2	FOREIGN KEY(last_updated_by) 	REFERENCES system_user(system_user_id)); 

-- Seed the CALENDAR table with the following data.
SELECT 'STEP #2' AS "CODE" FROM dual;

CREATE SEQUENCE calendar_s1 START WITH 1001;

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'January'
, 'JAN'
, TO_DATE('2009/01/01', 'yyyy/mm/dd')
, TO_DATE('2009/01/31', 'yyyy/mm/dd')
, 1
, SYSDATE
, 1
, SYSDATE );

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'February'
, 'FEB'
, TO_DATE('2009/02/01', 'yyyy/mm/dd')
, TO_DATE('2009/01/28', 'yyyy/mm/dd')
, 1
, SYSDATE
, 1
, SYSDATE );

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'March'
, 'MAR'
, TO_DATE('2009/03/01', 'yyyy/mm/dd')
, TO_DATE('2009/03/31', 'yyyy/mm/dd')
, 1
, SYSDATE
, 1
, SYSDATE );

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'April'
, 'APR'
, TO_DATE('2009/04/01', 'yyyy/mm/dd')
, TO_DATE('2009/04/30', 'yyyy/mm/dd')
, 1
, SYSDATE
, 1
, SYSDATE );

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'MAY'
, 'MAY'
, TO_DATE('2009/05/01', 'yyyy/mm/dd')
, TO_DATE('2009/05/31', 'yyyy/mm/dd')
, 1
, SYSDATE
, 1
, SYSDATE );

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'June'
, 'JUN'
, TO_DATE('2009/06/01', 'yyyy/mm/dd')
, TO_DATE('2009/06/30', 'yyyy/mm/dd')
, 1
, SYSDATE
, 1
, SYSDATE );

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'July'
, 'JUL'
, TO_DATE('2009/07/01', 'yyyy/mm/dd')
, TO_DATE('2009/07/31', 'yyyy/mm/dd')
, 1
, SYSDATE
, 1
, SYSDATE );

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'August'
, 'AUG'
, TO_DATE('2009/08/01', 'yyyy/mm/dd')
, TO_DATE('2009/08/31', 'yyyy/mm/dd')
, 1
, SYSDATE
, 1
, SYSDATE );

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'September'
, 'SEP'
, TO_DATE('2009/09/01', 'yyyy/mm/dd')
, TO_DATE('2009/09/30', 'yyyy/mm/dd')
, 1
, SYSDATE
, 1
, SYSDATE );

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'October'
, 'OCT'
, TO_DATE('2009/10/01', 'yyyy/mm/dd')
, TO_DATE('2009/10/31', 'yyyy/mm/dd')
, 1
, SYSDATE
, 1
, SYSDATE );

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'November'
, 'NOV'
, TO_DATE('2009/11/01', 'yyyy/mm/dd')
, TO_DATE('2009/11/30', 'yyyy/mm/dd')
, 1
, SYSDATE
, 1
, SYSDATE );

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'December'
, 'DEC'
, TO_DATE('2009/12/01', 'yyyy/mm/dd')
, TO_DATE('2009/12/31', 'yyyy/mm/dd')
, 1
, SYSDATE
, 1
, SYSDATE );

-- Import and merge the new *.csv files.
SELECT 'STEP #3' AS "CODE" FROM dual;

CREATE TABLE "STUDENT"."TRANSACTION_REVERSAL"
( transaction_id		NUMBER
, transaction_account    	VARCHAR2(15)
, transaction_type       	NUMBER
, transaction_date		DATE
, transaction_amount     	FLOAT
, rental_id			NUMBER
, payment_method_type    	NUMBER
, payment_account_number 	VARCHAR2(19)
, created_by			NUMBER
, creation_date  		DATE
, last_updated_by        	NUMBER
, last_update_date       	DATE)
ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY upload
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE CHARACTERSET US7ASCII
      BADFILE     'UPLOAD':'transaction_upload2.bad'
      DISCARDFILE 'UPLOAD':'transaction_upload2.dis'
      LOGFILE     'UPLOAD':'transaction_upload2.log'
      FIELDS TERMINATED BY ','
      OPTIONALLY ENCLOSED BY "'"
      MISSING FIELD VALUES ARE NULL )
      LOCATION
       ( 'transaction_upload2.csv'))
REJECT LIMIT UNLIMITED;

SET LONG 200000  -- Enables the display of the full statement.
SELECT   dbms_metadata.get_ddl('TABLE','TRANSACTION_REVERSAL') AS "Table Description"
FROM     dual;
 
-- Set a local variable of a character large object (CLOB).
VARIABLE ddl_text CLOB
 
-- Get the internal DDL command for the TRANSACTION table from the data dictionary.
SELECT dbms_metadata.get_ddl('TABLE','TRANSACTION') FROM dual;
 
-- Get the internal DDL command for the external TRANSACTION_UPLOAD table from the data dictionary.
SELECT dbms_metadata.get_ddl('TABLE','TRANSACTION_UPLOAD') FROM dual;

INSERT INTO transaction
(SELECT transaction_s1.NEXTVAL
,	transaction_account
, 	transaction_type
,	transaction_date
,	transaction_amount
,	rental_id
,	payment_method_type
,	payment_account_number
,	created_by
,	creation_date
, 	last_updated_by
,	last_update_date
 FROM    transaction_reversal);

COLUMN "Debit Transactions"  FORMAT A20
COLUMN "Credit Transactions" FORMAT A20
COLUMN "All Transactions"    FORMAT A20
 
-- Check current contents of the model.
SELECT 'SELECT record counts' AS "Statement" FROM dual;
SELECT   LPAD(TO_CHAR(c1.transaction_count,'99,999'),19,' ') AS "Debit Transactions"
,        LPAD(TO_CHAR(c2.transaction_count,'99,999'),19,' ') AS "Credit Transactions"
,        LPAD(TO_CHAR(c3.transaction_count,'99,999'),19,' ') AS "All Transactions"
FROM    (SELECT COUNT(*) AS transaction_count FROM transaction WHERE transaction_account = '111-111-111-111') c1 CROSS JOIN
        (SELECT COUNT(*) AS transaction_count FROM transaction WHERE transaction_account = '222-222-222-222') c2 CROSS JOIN
        (SELECT COUNT(*) AS transaction_count FROM transaction) c3;

-- Create the following transformation report by a CROSS JOIN between the TRANSACTION and CALENDAR tables.

COLUMN Transaction FORMAT A15
COLUMN January   FORMAT A10
COLUMN February  FORMAT A10
COLUMN March     FORMAT A10
COLUMN F1Q       FORMAT A10
COLUMN April     FORMAT A10
COLUMN May       FORMAT A10
COLUMN June      FORMAT A10
COLUMN F2Q       FORMAT A10
COLUMN July      FORMAT A10
COLUMN August    FORMAT A10
COLUMN September FORMAT A10
COLUMN F3Q       FORMAT A10
COLUMN October   FORMAT A10
COLUMN November  FORMAT A10
COLUMN December  FORMAT A10
COLUMN F4Q       FORMAT A10
COLUMN YTD       FORMAT A12

SELECT	transaction_account 	
,	january   			
, 	february  		
,	march 	  		
, 	f1q       		
,	april	  		
, 	may 	  		
, 	june	  		
, 	july	  		
,	f2q			
, 	august    		
, 	september 		
,	f3q			
,	october   		
, 	november   		
, 	december  		
,       f4q 	  		
,       ytd	  		
FROM (
SELECT 	CASE 
		WHEN t.transaction_account = '111-111-111-111' 
		THEN 'Debit'
		WHEN t.transaction_account = '222-222-222-222' 
		THEN 'Credit'
	END AS "TRANSACTION_ACCOUNT"
,	CASE
           	WHEN t.transaction_account = '111-111-111-111' 
		THEN 1
           	WHEN t.transaction_account = '222-222-222-222' 
		THEN 2
        END AS "SORTKEY"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) = 1 
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "JANUARY"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) = 2 
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "FEBRUARY"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) = 3 
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "MARCH"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) IN (1, 2, 3) 
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "F1Q"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) = 4 
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "APRIL"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) = 5 
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "MAY"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) = 6 
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "JUNE"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) IN (4, 5, 6) 
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "F2Q"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) = 7 
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "JULY"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) = 8 
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "AUGUST"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) = 9 
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "SEPTEMBER"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) IN (7, 8, 9)
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "F3Q"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) = 10
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "OCTOBER"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) = 11
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "NOVEMBER"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) = 12 
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "DECEMBER"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) IN (10, 11, 12)
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "F4Q"
,	LPAD(TO_CHAR
        (SUM(CASE
		WHEN EXTRACT(MONTH FROM transaction_date) IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
		AND EXTRACT(YEAR FROM transaction_date) = 2009 
	     THEN
             	CASE
                	WHEN cl.common_lookup_type = 'DEBIT'
                   	THEN t.transaction_amount
                   	ELSE t.transaction_amount * -1
                END
             END),'99,999.00'),10,' ') AS "YTD"
FROM	transaction t INNER JOIN common_lookup cl
ON      t.transaction_type = cl.common_lookup_id 
WHERE   cl.common_lookup_table = 'TRANSACTION'
AND     cl.common_lookup_column = 'TRANSACTION_TYPE' 
GROUP BY CASE
		WHEN t.transaction_account = '111-111-111-111' 
		THEN 'Debit'
           	WHEN t.transaction_account = '222-222-222-222' 
		THEN 'Credit'
         END
,        CASE
           	WHEN t.transaction_account = '111-111-111-111' 
		THEN 1
           	WHEN t.transaction_account = '222-222-222-222' 
		THEN 2
         END);
		

SPOOL OFF
