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
--   sql> @apply_oracle_lab6.sql
--
-- ----------------------------------------------------------------------

-- Run the prior lab script.
@/home/student/Data/cit225/oracle/lab5/apply_oracle_lab5.sql

SPOOL apply_oracle_lab6.log

-- Change the RENTAL_ITEM table by adding the RENTAL_ITEM_TYPE and RENTAL_ITEM_PRICE columns. Both columns should use a NUMBER data type.
ALTER TABLE rental_item
	ADD (rental_item_type	NUMBER)
	ADD (rental_item_price 	NUMBER);

-- Create the PRICE table as per the specification.
CREATE TABLE price
( price_id			NUMBER
, item_id			NUMBER		CONSTRAINT nn_price_1 NOT NULL
, price_type			NUMBER		
, active_flag			VARCHAR2(1)	CONSTRAINT nn_price_2 NOT NULL
, start_date			DATE		CONSTRAINT nn_price_3 NOT NULL
, end_date			DATE
, amount			NUMBER		CONSTRAINT nn_price_4 NOT NULL
, created_by			NUMBER		CONSTRAINT nn_price_5 NOT NULL
, creation_date			DATE		CONSTRAINT nn_price_6 NOT NULL
, last_updated_by		NUMBER		CONSTRAINT nn_price_7 NOT NULL
, last_update_date		DATE		CONSTRAINT nn_price_8 NOT NULL
, CONSTRAINT yn_price 		CHECK (active_flag IN ('Y','N'))
, CONSTRAINT pk_price_1		PRIMARY KEY(price_id)
, CONSTRAINT fk_price_1      	FOREIGN KEY(item_id) REFERENCES item(item_id)
, CONSTRAINT fk_price_2		FOREIGN KEY(price_type) REFERENCES common_lookup(common_lookup_id)
, CONSTRAINT fk_price_3		FOREIGN KEY(created_by) REFERENCES system_user(system_user_id)
, CONSTRAINT fk_price_4		FOREIGN KEY(last_updated_by) REFERENCES system_user(system_user_id) );

-- Insert new data into the model
	-- a. Rename the ITEM_RELEASE_DATE column of the ITEM table to RELEASE_DATE.
ALTER TABLE item RENAME COLUMN item_release_date TO release_date;

	-- b. Insert three new DVD releases into the ITEM table.
INSERT INTO item 
VALUES
( item_s1.nextval
, '8726-95549-4'
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'DVD_WIDE_SCREEN')
, 'Tron'
, ''
, 'PG'
, SYSDATE - 15
, 3
, SYSDATE
, 3
, SYSDATE);

INSERT INTO item 
VALUES
( item_s1.nextval
, '9635-04630-3'
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'DVD_WIDE_SCREEN')
, 'Ender''s Game'
, ''
, 'PG13'
, SYSDATE - 15
, 3
, SYSDATE
, 3
, SYSDATE);

INSERT INTO item 
VALUES
( item_s1.nextval
, '7817-86458-5'
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'DVD_WIDE_SCREEN')
, 'Elysium'
, ''
, 'Mature'
, SYSDATE - 15
, 3
, SYSDATE
, 3
, SYSDATE);

	-- c. Insert a new row in the MEMBER table, and three new rows in the CONTACT, ADDRESS, STREET_ADDRESS, and TELEPHONE tables.
INSERT INTO member 
VALUES
( member_s1.nextval
, 1002
,'X17-520-02'
,'6031-0000-1111-1024'
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_context = 'MEMBER'
  AND      common_lookup_type = 'DISCOVER_CARD')
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO contact 
VALUES
( contact_s1.nextval
, member_s1.currval
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_context = 'CONTACT'
  AND      common_lookup_type = 'CUSTOMER')
, 'Harry'
, ''
, 'Potter'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO address 
VALUES
( address_s1.nextval
, contact_s1.currval
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'HOME')
, 'Provo'
, 'Utah'
, '84097'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO street_address 
VALUES
( street_address_s1.nextval
, address_s1.currval
, '16 El Camino Real'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO telephone 
VALUES
( telephone_s1.nextval
, address_s1.currval
, contact_s1.currval
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'HOME')
, 'USA'
, '409'
, '555-5555'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO contact 
VALUES
( contact_s1.nextval
, member_s1.currval
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_context = 'CONTACT'
  AND      common_lookup_type = 'CUSTOMER')
, 'Ginny'
, ''
, 'Potter'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO address 
VALUES
( address_s1.nextval
, contact_s1.currval
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'HOME')
, 'Provo'
, 'Utah'
, '84097'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO street_address 
VALUES
( street_address_s1.nextval
, address_s1.currval
, '16 El Camino Real'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO telephone 
VALUES
( telephone_s1.nextval
, address_s1.currval
, contact_s1.currval
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'HOME')
, 'USA'
, '409'
, '555-5555'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO contact 
VALUES
( contact_s1.nextval
, member_s1.currval
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_context = 'CONTACT'
  AND      common_lookup_type = 'CUSTOMER')
, 'Lily'
, 'Luna'
, 'Potter'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO address 
VALUES
( address_s1.nextval
, contact_s1.currval
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'HOME')
, 'Provo'
, 'Utah'
, '84097'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO street_address 
VALUES
( street_address_s1.nextval
, address_s1.currval
, '16 El Camino Real'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO telephone 
VALUES
( telephone_s1.nextval
, address_s1.currval
, contact_s1.currval
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'HOME')
, 'USA'
, '409'
, '555-5555'
, 1
, SYSDATE
, 1
, SYSDATE);

	-- d. Insert three new rows in the RENTAL and four new rows in the RENTAL_ITEM tables.
INSERT INTO rental 
VALUES
( rental_s1.nextval
,(SELECT   contact_id
  FROM     contact
  WHERE    last_name = 'Potter'
  AND      first_name = 'Harry')
, TRUNC(SYSDATE)
, TRUNC(SYSDATE) + 1
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO rental_item
( rental_item_id
, rental_id
, item_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_s1.nextval
,(SELECT   r.rental_id
  FROM     rental r
  ,        contact c
  WHERE    r.customer_id = c.contact_id
  AND      c.last_name = 'Potter'
  AND      c.first_name = 'Harry')
,(SELECT   i.item_id
  FROM     item i
  ,        common_lookup cl
  WHERE    i.item_title = 'Tron'
  AND      i.item_type = cl.common_lookup_id
  AND      cl.common_lookup_type = 'DVD_WIDE_SCREEN')
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO rental_item
( rental_item_id
, rental_id
, item_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_s1.nextval
,(SELECT   r.rental_id
  FROM     rental r
  ,        contact c
  WHERE    r.customer_id = c.contact_id
  AND      c.last_name = 'Potter'
  AND      c.first_name = 'Harry')
,(SELECT   i.item_id
  FROM     item i
  ,        common_lookup cl
  WHERE    i.item_title = 'Star Wars II'
  AND      i.item_type = cl.common_lookup_id
  AND      cl.common_lookup_type = 'DVD_WIDE_SCREEN')
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO rental 
VALUES
( rental_s1.nextval
,(SELECT   contact_id
  FROM     contact
  WHERE    last_name = 'Potter'
  AND      first_name = 'Ginny')
, TRUNC(SYSDATE)
, TRUNC(SYSDATE) + 3
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO rental_item
( rental_item_id
, rental_id
, item_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_s1.nextval
,(SELECT   r.rental_id
  FROM     rental r
  ,        contact c
  WHERE    r.customer_id = c.contact_id
  AND      c.last_name = 'Potter'
  AND      c.first_name = 'Ginny')
,(SELECT   i.item_id
  FROM     item i
  ,        common_lookup cl
  WHERE    i.item_title = 'Ender''s Game'
  AND      i.item_type = cl.common_lookup_id
  AND      cl.common_lookup_type = 'DVD_WIDE_SCREEN')
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO rental 
VALUES
( rental_s1.nextval
,(SELECT   contact_id
  FROM     contact
  WHERE    last_name = 'Potter'
  AND      first_name = 'Lily')
, TRUNC(SYSDATE)
, TRUNC(SYSDATE) + 5
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO rental_item
( rental_item_id
, rental_id
, item_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( rental_item_s1.nextval
,(SELECT   r.rental_id
  FROM     rental r
  ,        contact c
  WHERE    r.customer_id = c.contact_id
  AND      c.last_name = 'Potter'
  AND      c.first_name = 'Lily')
,(SELECT   i.item_id
  FROM     item i
  ,        common_lookup cl
  WHERE    i.item_title = 'Elysium'
  AND      i.item_type = cl.common_lookup_id
  AND      cl.common_lookup_type = 'DVD_WIDE_SCREEN')
, 1
, SYSDATE
, 1
, SYSDATE);

-- Modify the design of the COMMON_LOOKUP table following the definitions, insert new data into the model, and update old non-compliant design data in the model.
	-- a. Drop the common_lookup_n1 and common_lookup_u2 indexes.
DROP INDEX common_lookup_n1;
DROP INDEX common_lookup_u2;

	-- b. Add three new columns to the common_lookup table
ALTER TABLE common_lookup
	ADD (common_lookup_table		VARCHAR2(30))
	ADD (common_lookup_column		VARCHAR2(30))
	ADD (common_lookup_code 		VARCHAR2(30));

	-- c. Migrate data and seed new columns with ecisting data
UPDATE 	common_lookup
SET 	common_lookup_table =
		CASE
			WHEN common_lookup_context = 'MULTIPLE' THEN 'ADDRESS'
			ELSE common_lookup_context
		END
,	common_lookup_column =
		CASE
			WHEN common_lookup_type = 'VISA_CARD' THEN 'CREDIT_CARD_TYPE'
			WHEN common_lookup_type = 'MASTER_CARD' THEN 'CREDIT_CARD_TYPE'
			WHEN common_lookup_type = 'DISCOVER_CARD' THEN 'CREDIT_CARD_TYPE'
			WHEN common_lookup_context = 'MEMBER' THEN 'MEMBER_TYPE'
			WHEN common_lookup_type = 'INDIVIDUAL' THEN common_lookup_type || '_TYPE'
			WHEN common_lookup_type = 'GROUP' THEN common_lookup_type || '_TYPE'
			WHEN common_lookup_context = 'MULTIPLE' THEN 'ADDRESS_TYPE'
			ELSE common_lookup_context || '_TYPE'
		END;

INSERT INTO common_lookup 
VALUES
( common_lookup_s1.nextval
, 'TELEPHONE'
, 'HOME'
, 'Home Telephone'
, 1
, SYSDATE
, 1
, SYSDATE
, 'TELEPHONE'
, 'TELEPHONE_TYPE'
, '');

INSERT INTO common_lookup 
VALUES
( common_lookup_s1.nextval
, 'TELEPHONE'
, 'WORK'
, 'Home Telephone'
, 1
, SYSDATE
, 1
, SYSDATE
, 'TELEPHONE'
, 'TELEPHONE_TYPE'
, '');

UPDATE 	telephone
SET 	telephone_type = 1016;

	-- d. Remove obsolete columns, apply not null constraints, and create a new unique index for the natural key of the COMMON_LOOKUP table.
ALTER TABLE common_lookup
	DROP (common_lookup_context);

ALTER TABLE common_lookup
MODIFY common_lookup_table 	VARCHAR2(30) CONSTRAINT nn_clookup_8 NOT NULL 
MODIFY common_lookup_column 	VARCHAR2(30) CONSTRAINT nn_clookup_9 NOT NULL;


CREATE UNIQUE INDEX common_lookup_u2
  ON common_lookup(common_lookup_column,common_lookup_type);

-- Verification
	-- Step 1
SET NULL ''
COLUMN table_name   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = 'RENTAL_ITEM'
ORDER BY 2;

	-- Step 2
-- Checks for new table
SET NULL ''
COLUMN table_name   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = 'PRICE'
ORDER BY 2;

-- checks for yn_price constraint
COLUMN constraint_name   FORMAT A16
COLUMN search_condition  FORMAT A30
SELECT   uc.constraint_name
,        uc.search_condition
FROM     user_constraints uc INNER JOIN user_cons_columns ucc
ON       uc.table_name = ucc.table_name
AND      uc.constraint_name = ucc.constraint_name
WHERE    uc.table_name = UPPER('price')
AND      ucc.column_name = UPPER('active_flag')
AND      uc.constraint_name = UPPER('yn_price')
AND      uc.constraint_type = 'C';

	-- Step 3
-- check renamed column
SET NULL ''
COLUMN TABLE_NAME   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   TABLE_NAME
,        column_id
,        column_name
,        CASE
           WHEN NULLABLE = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS NULLABLE
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    TABLE_NAME = 'ITEM'
ORDER BY 2;

-- check 3 new DVD releases
SELECT   i.item_title
,        SYSDATE AS today
,        i.release_date
FROM     item i
WHERE   (SYSDATE - i.release_date) < 31;

-- check for 3 new rows in contact, address, street_address, and telephone tables
COLUMN full_name FORMAT A20
COLUMN city      FORMAT A10
COLUMN state     FORMAT A10
SELECT   c.last_name || ', ' || c.first_name AS full_name
,        a.city
,        a.state_province AS state
FROM     member m INNER JOIN contact c
ON       m.member_id = c.member_id INNER JOIN address a
ON       c.contact_id = a.contact_id INNER JOIN street_address sa
ON       a.address_id = sa.address_id INNER JOIN telephone t
ON       c.contact_id = t.contact_id
WHERE    c.last_name = 'Potter';

-- check for 4 rentals
COLUMN full_name   FORMAT A18
COLUMN rental_id   FORMAT 9999
COLUMN rental_days FORMAT A14
COLUMN rentals     FORMAT 9999
COLUMN items       FORMAT 9999
SELECT   c.last_name||', '||c.first_name||' '||c.middle_name AS full_name
,        r.rental_id
,       (r.return_date - r.check_out_date) || '-DAY RENTAL' AS rental_days
,        COUNT(DISTINCT r.rental_id) AS rentals
,        COUNT(ri.rental_item_id) AS items
FROM     rental r INNER JOIN rental_item ri
ON       r.rental_id = ri.rental_id INNER JOIN contact c
ON       r.customer_id = c.contact_id
WHERE   (SYSDATE - r.check_out_date) < 15
AND      c.last_name = 'Potter'
GROUP BY c.last_name||', '||c.first_name||' '||c.middle_name
,        r.rental_id
,       (r.return_date - r.check_out_date) || '-DAY RENTAL'
ORDER BY 2;

	-- Step 4
-- check that indexes were dropped
COLUMN table_name FORMAT A14
COLUMN index_name FORMAT A20
SELECT   table_name
,        index_name
FROM     user_indexes
WHERE    table_name = 'COMMON_LOOKUP';

-- check for added columns to common_lookup
SET NULL ''
COLUMN table_name   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = 'COMMON_LOOKUP'
ORDER BY 2;

-- check for migrated data and seeded new columns as well as re-structuring of the common_lookup table
SET NULL ''
COLUMN table_name   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = 'COMMON_LOOKUP'
ORDER BY 2;

COLUMN common_lookup_table  FORMAT A20
COLUMN common_lookup_column FORMAT A20
COLUMN common_lookup_type   FORMAT A20
SELECT   common_lookup_table
,        common_lookup_column
,        common_lookup_type
FROM     common_lookup
ORDER BY 1, 2, 3;

COLUMN common_lookup_table  FORMAT A14 HEADING "Common|Lookup Table"
COLUMN common_lookup_column FORMAT A14 HEADING "Common|Lookup Column"
COLUMN common_lookup_type   FORMAT A8  HEADING "Common|Lookup|Type"
COLUMN count_dependent      FORMAT 999 HEADING "Count of|Foreign|Keys"
COLUMN count_lookup         FORMAT 999 HEADING "Count of|Primary|Keys"
SELECT   cl.common_lookup_table
,        cl.common_lookup_column
,        cl.common_lookup_type
,        COUNT(a.address_id) AS count_dependent
,        COUNT(DISTINCT cl.common_lookup_table) AS count_lookup
FROM     address a RIGHT JOIN common_lookup cl
ON       a.address_type = cl.common_lookup_id
WHERE    cl.common_lookup_table = 'ADDRESS'
AND      cl.common_lookup_column = 'ADDRESS_TYPE'
AND      cl.common_lookup_type IN ('HOME','WORK')
GROUP BY cl.common_lookup_table
,        cl.common_lookup_column
,        cl.common_lookup_type
UNION
SELECT   cl.common_lookup_table
,        cl.common_lookup_column
,        cl.common_lookup_type
,        COUNT(t.telephone_id) AS count_dependent
,        COUNT(DISTINCT cl.common_lookup_table) AS count_lookup
FROM     telephone t RIGHT JOIN common_lookup cl
ON       t.telephone_type = cl.common_lookup_id
WHERE    cl.common_lookup_table = 'TELEPHONE'
AND      cl.common_lookup_column = 'TELEPHONE_TYPE'
AND      cl.common_lookup_type IN ('HOME','WORK')
GROUP BY cl.common_lookup_table
,        cl.common_lookup_column
,        cl.common_lookup_type;

-- check for new constraints added to common_lookup table
SET NULL ''
COLUMN table_name   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = 'COMMON_LOOKUP'
ORDER BY 2;

-- check for creation of unique index
COLUMN table_name FORMAT A14
COLUMN index_name FORMAT A20
SELECT   table_name
,        index_name
FROM     user_indexes
WHERE    table_name = 'COMMON_LOOKUP';

SPOOL OFF
