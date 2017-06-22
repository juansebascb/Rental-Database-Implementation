# Rental-Database-Implementation

This is the semester long project for the CIT 225 class at BYU-Idaho from the year 2017 in the winter track.

This project is composed of scripts that run in Oracle SQL. The scripts make tables and restrictions in the database.
The scripts also populate some of the tables with data. There are both, examples of viewing/verifyng data in the 
databases as well as manipulation of data and the tables.
These scripts make a database for a business that rents media content. There is also an example of how to import 
a file that has a large amnount of data and how to manipulate that data to make tables that help keep track of the
transactions.
These scripts make tables for airports, transactions, calendar, prices, rental items, items, rentals, telephones, street 
addresses, addresses, contacts, members, common lookups and the system users. For more details of what each of 
them contains, that can be found in the scripts provided in this repository.

*NOTE: Each of the scripts calls the script with the previous number. For example, apply_oracle_lab12.sql 
calls apply_oracle_lab11.sql, the script apply_oracle_lab11.sql calls apply_oracle_lab10.sql and so on until 
it reaches apply_oracle_lab5.sql. The script apply_oracle_lab5.sql calls cleanup_oracle.sql, create_oracle_store.sql 
and seed_oracle_store.sql. This means that it is necessary to run apply_oracle_lab12.sql to get the entire project
running.
