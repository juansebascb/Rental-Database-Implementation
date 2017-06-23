# Rental-Database-Implementation

This is the semester long project for the CIT 225 class at BYU-Idaho from the year 2017 during the winter track.

This project is composed of scripts that run in Oracle SQL. The scripts make tables and restrictions in the database.
The scripts also populate some of the tables with data. The scripts are for viewing, verifying, manipulating, and 
modifying data and tables in the databases.
These scripts make a database for a business that rents media content. There is also an example of how to import 
a file that has a large amount of data and how to manipulate the data to make tables which helps keep track of the
transactions.
These scripts create tables for airports, transactions, calendars, prices, rental items, items, rentals, telephone numbers, 
street addresses, addresses, contacts, members, common lookups and the system users. Details of what each table contains 
can be found in the scripts provided in this repository.

*NOTE: Each of the scripts calls the script with the previous number. For example, apply_oracle_lab12.sql 
calls apply_oracle_lab11.sql, the script apply_oracle_lab11.sql calls apply_oracle_lab10.sql and so on until 
it reaches apply_oracle_lab5.sql. The script apply_oracle_lab5.sql calls cleanup_oracle.sql, create_oracle_store.sql 
and seed_oracle_store.sql. This means that it is necessary to run apply_oracle_lab12.sql to get the entire project
running.
