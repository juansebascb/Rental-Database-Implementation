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
--   sql> @apply_oracle_lab8.sql
--
-- ----------------------------------------------------------------------

-- Run the prior lab script.
@/home/student/Data/cit225/oracle/lab7/apply_oracle_lab7.sql

SPOOL apply_oracle_lab8.log

-- Using the query you developed in Step #04 of Lab #07, add the result set to the PRICE table.
SELECT	'Step #1' AS "CODE" FROM dual;
CREATE SEQUENCE price_s1 START WITH 1001;

INSERT INTO price
( price_id
, item_id
, price_type
, active_flag
, start_date
, end_date
, amount
, created_by
, creation_date
, last_updated_by
, last_update_date)
SELECT	price_s1.nextval
,	i.item_id
,	cl.common_lookup_id
,	af.active_flag
,	CASE
		WHEN (TRUNC(SYSDATE) - i.release_date) <= 30 OR
		     (TRUNC(SYSDATE) - i.release_date) > 30 AND
		      af.active_flag = 'N' 
		THEN i.release_date
		ELSE i.release_date + 31
	END AS
,	CASE
		WHEN (TRUNC(SYSDATE) - i.release_date) > 30 AND 
		      af.active_flag = 'N' 
		THEN i.release_date + 30
	END AS
,	CASE
		WHEN (TRUNC(SYSDATE) - i.release_date) <= 30 
		THEN
		      	CASE
				WHEN dr.rental_days = 1 
				THEN 3
				WHEN dr.rental_days = 3 
				THEN 10
				WHEN dr.rental_days = 5 
				THEN 15 --new rentals
			END
		WHEN (TRUNC(SYSDATE) - i.release_date) > 30 AND
		      af.active_flag = 'N' 
		THEN
		     	CASE
		    		WHEN dr.rental_days = 1 
				THEN 3
		     		WHEN dr.rental_days = 3 
				THEN 10
		    		WHEN dr.rental_days = 5 
				THEN 15
		     	END
		ELSE
			CASE
		    	 	WHEN dr.rental_days = 1 
				THEN 1
		     		WHEN dr.rental_days = 3 
				THEN 3
		     		WHEN dr.rental_days = 5 
				THEN 5
		     	END
	END AS
, 1
, SYSDATE
, 1
, SYSDATE
FROM		 item i CROSS JOIN
		(SELECT 'Y' AS active_flag FROM dual
		 UNION ALL
 	      	 SELECT 'N' AS active_flag FROM dual) af CROSS JOIN  	     
		(SELECT '1' AS rental_days FROM dual
 	      	 UNION ALL
  	      	 SELECT '3' AS rental_days FROM dual
    	      	 UNION ALL
   	      	 SELECT '5' AS rental_days FROM dual) dr INNER JOIN
  	     	 common_lookup cl ON dr.rental_days = SUBSTR(cl.common_lookup_type,1,1)
WHERE    cl.common_lookup_table = 'PRICE'
AND      cl.common_lookup_column = 'PRICE_TYPE'
AND NOT	 ((af.active_flag = 'N' AND (TRUNC(SYSDATE) - 30) < i.release_date));

-- Add the NOT NULL constraint to the PRICE_TYPE column of the PRICE table.
SELECT	'Step #2' AS "CODE" FROM dual;
ALTER TABLE price
MODIFY price_type	NUMBER CONSTRAINT nn_price_10 NOT NULL;

-- You should update the RENTAL_ITEM_PRICE column of the RENTAL_ITEM table.
SELECT	'Step #3' AS "CODE" FROM dual;
UPDATE   rental_item ri
SET      rental_item_price =
          (SELECT   p.amount
           FROM     price p INNER JOIN common_lookup cl1
           ON       p.price_type = cl1.common_lookup_id CROSS JOIN rental r
                    CROSS JOIN common_lookup cl2 
           WHERE    p.item_id = ri.item_id AND ri.rental_id = r.rental_id
           AND      ri.rental_item_type = cl2.common_lookup_id
           AND      cl1.common_lookup_code = cl2.common_lookup_code
           AND      r.check_out_date
                      BETWEEN p.start_date AND NVL (p.end_date, TRUNC(SYSDATE + 1)));

-- Add a NOT NULL constraint to the RENTAL_ITEM_PRICE column of the RENTAL_ITEM table.
SELECT	'Step #4' AS "CODE" FROM dual;
-- I am not sure why but I already have this column set for NOT NULL but if you want to see the code:
-- ALTER TABLE rental_item MODIFY rental_item_price NUMBER CONSTRAINT nn_rental_item_9 NOT NULL;

-- Veification
	-- step 1
SELECT 'Step #1' AS "VERIFY" FROM dual;
SELECT  'OLD Y' AS "Type"
,        COUNT(CASE WHEN amount = 1 THEN 1 END) AS "1-Day"
,        COUNT(CASE WHEN amount = 3 THEN 1 END) AS "3-Day"
,        COUNT(CASE WHEN amount = 5 THEN 1 END) AS "5-Day"
,        COUNT(*) AS "TOTAL"
FROM     price p , item i
WHERE    active_flag = 'Y' AND i.item_id = p.item_id
AND     (TRUNC(SYSDATE) - TRUNC(i.release_date)) > 30
AND      end_date IS NULL
UNION ALL
SELECT  'OLD N' AS "Type"
,        COUNT(CASE WHEN amount =  3 THEN 1 END) AS "1-Day"
,        COUNT(CASE WHEN amount = 10 THEN 1 END) AS "3-Day"
,        COUNT(CASE WHEN amount = 15 THEN 1 END) AS "5-Day"
,        COUNT(*) AS "TOTAL"
FROM     price p , item i
WHERE    active_flag = 'N' AND i.item_id = p.item_id
AND     (TRUNC(SYSDATE) - TRUNC(i.release_date)) > 30
AND NOT end_date IS NULL
UNION ALL
SELECT  'NEW Y' AS "Type"
,        COUNT(CASE WHEN amount =  3 THEN 1 END) AS "1-Day"
,        COUNT(CASE WHEN amount = 10 THEN 1 END) AS "3-Day"
,        COUNT(CASE WHEN amount = 15 THEN 1 END) AS "5-Day"
,        COUNT(*) AS "TOTAL"
FROM     price p , item i
WHERE    active_flag = 'Y' AND i.item_id = p.item_id
AND     (TRUNC(SYSDATE) - TRUNC(i.release_date)) < 31
AND      end_date IS NULL
UNION ALL
SELECT  'NEW N' AS "Type"
,        COUNT(CASE WHEN amount = 1 THEN 1 END) AS "1-Day"
,        COUNT(CASE WHEN amount = 3 THEN 1 END) AS "3-Day"
,        COUNT(CASE WHEN amount = 5 THEN 1 END) AS "5-Day"
,        COUNT(*) AS "TOTAL"
FROM     price p , item i
WHERE    active_flag = 'N' AND i.item_id = p.item_id
AND     (TRUNC(SYSDATE) - TRUNC(i.release_date)) < 31
AND      NOT (end_date IS NULL);

	-- Step 2
SELECT 'Step #2' AS "VERIFY" FROM dual;
COLUMN CONSTRAINT FORMAT A10
SELECT   TABLE_NAME
,        column_name
,        CASE
           WHEN NULLABLE = 'N' THEN 'NOT NULL'
           ELSE 'NULLABLE'
         END AS CONSTRAINT
FROM     user_tab_columns
WHERE    TABLE_NAME = 'PRICE'
AND      column_name = 'PRICE_TYPE';

	-- Step 3
SELECT 'Step #3' AS "VERIFY" FROM dual;
SELECT   ri.rental_item_id
,        ri.rental_item_price
,        p.amount
FROM     price p INNER JOIN common_lookup cl1
ON       p.price_type = cl1.common_lookup_id INNER JOIN rental_item ri 
ON       p.item_id = ri.item_id INNER JOIN common_lookup cl2
ON       ri.rental_item_type = cl2.common_lookup_id INNER JOIN rental r
ON       ri.rental_id = r.rental_id
WHERE    cl1.common_lookup_code = cl2.common_lookup_code
AND      r.check_out_date
BETWEEN  p.start_date AND NVL(p.end_date,TRUNC(SYSDATE) + 1)
ORDER BY 1;

	-- Step 4
SELECT 'Step #4' AS "VERIFY" FROM dual;
COLUMN CONSTRAINT FORMAT A10
SELECT   TABLE_NAME
,        column_name
,        CASE
           WHEN NULLABLE = 'N' THEN 'NOT NULL'
           ELSE 'NULLABLE'
         END AS CONSTRAINT
FROM     user_tab_columns
WHERE    TABLE_NAME = 'RENTAL_ITEM'
AND      column_name = 'RENTAL_ITEM_PRICE';

SPOOL OFF
