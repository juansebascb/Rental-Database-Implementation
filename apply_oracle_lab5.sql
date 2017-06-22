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
--   sql> @apply_oracle_lab5.sql
--
-- ----------------------------------------------------------------------

-- Run the lib scripts.
@/home/student/Data/cit225/oracle/lib/cleanup_oracle.sql
@/home/student/Data/cit225/oracle/lib/create_oracle_store.sql
@/home/student/Data/cit225/oracle/lib/seed_oracle_store.sql

-- SPOOL
SPOOL apply_oracle_lab5.log
-- Add your lab here:
-- ----------------------------------------------------------------------

-- Write inner join queries that use the USING subclause and return the results listed on the web page.
	-- a.
SELECT 	member_id, contact_id
FROM 	member m INNER JOIN contact c USING(member_id);

	-- b.
SELECT	contact_id, address_id
FROM	contact c INNER JOIN address a USING(contact_id);

	-- c.
SELECT	address_id, street_address_id
FROM	address a INNER JOIN street_address sa USING(address_id);

	-- d.
SELECT	contact_id, telephone_id
FROM	contact c INNER JOIN telephone t USING(contact_id);

-- Write inner join queries that use the ON subclause and return the following results listed on the web page.
	-- a.
SELECT 	contact_id, system_user_id
FROM 	contact c INNER JOIN system_user su
ON 	c.created_by = su.system_user_id;

	-- b.
SELECT	contact_id, system_user_id
FROM 	contact c INNER JOIN system_user su
ON	c.last_updated_by = su.system_user_id;

-- Write inner join queries that use the ON subclause and return the following results listed on the web page.
	-- a.
SELECT	su1.system_user_id, su1.created_by, su2.system_user_id
FROM	system_user su1 INNER JOIN system_user su2
ON	su1.created_by = su2.system_user_id INNER JOIN system_user su3
ON	su2.created_by = su3.system_user_id;

	-- b.
SELECT	su1.system_user_id, su1.last_updated_by, su2.system_user_id
FROM	system_user su1 INNER JOIN system_user su2
ON	su1.last_updated_by = su2.system_user_id INNER JOIN system_user su3
ON	su2.last_updated_by = su3.system_user_id;

	-- c.
SELECT 	su1.system_user_name AS "System User", su1.system_user_id AS "System ID"
, su2.system_user_name AS "Created User", su2.system_user_id AS "Created By"
, su3.system_user_name AS "Updated User", su3.last_updated_by AS "Updated By"
FROM	system_user su1 INNER JOIN system_user su2
ON	su1.created_by = su2.system_user_id INNER JOIN system_user su3
ON	su1.last_updated_by = su3.system_user_id;

-- Display the RENTAL_ID column from the RENTAL table, the RENTAL_ID and ITEM_ID from the RENTAL_ITEM table, and ITEM_ID column from the ITEM table.
SELECT	r.rental_id, ri.rental_id, ri.item_id, i.item_id
FROM	rental r INNER JOIN rental_item ri 
ON	r.rental_id = ri.rental_id INNER JOIN item i
ON	ri.item_id = i.item_id;

SPOOL OFF
