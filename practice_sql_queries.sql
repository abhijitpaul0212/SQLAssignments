-- @@@@@@@ --  

# Create a database 
CREATE DATABASE IF NOT EXISTS practice_sql;  

use practice_sql;

# Create 'city' table
CREATE TABLE if not exists `city`(
    `id` varchar(10) DEFAULT NULL,
    `name` varchar(30) DEFAULT NULL,
    `countrycode` varchar(10) DEFAULT NULL,
    `district` varchar(20) DEFAULT NULL,
    `population` varchar(10) DEFAULT NULL);

truncate table city;

# Import records to 'city' table from city_table_mysql.csv into your MySQL database using MySQLWorkbench 

# Create 'station' table
CREATE TABLE if not exists `station` (
    `id` varchar(10) DEFAULT NULL,
    `city` varchar(30) DEFAULT NULL,
    `state` varchar(10) DEFAULT NULL,
    `lat_n` int DEFAULT NULL,
    `long_w` int DEFAULT NULL
);

truncate table station;

# Import records to 'station' table from 'station_table_mysql.csv' into your MySQL database using MySQLWorkbench 


-- @@@@@ --


# Assignment SQL

#1 Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
select * from city where countrycode = 'USA' and population > 100000 ;

#2 Query the NAME field for all American cities in the CITY table with populations larger than 120000.
select * from city where countrycode = 'USA' and population > 120000;

#3 Query all columns (attributes) for every row in the CITY table.
DESCRIBE city;

#4 Query all columns for a city in CITY with the ID 1661.
select * from city where id='1661';

#5 Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
select * from city where countrycode='JPN';

#6  Query a list of CITY and STATE from the STATION table.
select * from station;

#7 Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
select distinct(city) from station where id in (select id from station where mod(id,2) = 0);

#8  Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table. 
select (count(city) - count(distinct(city))) from station;

#9 Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
select city, char_length(city) from station where char_length(city) = (select min(char_length(city)) as min_city_length from station) order by city limit 1;

select city, char_length(city) from station where char_length(city) = (select max(char_length(city)) as max_city_length from station) order by city limit 1;

#10 Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
select distinct(city) from station where lower(left(city,1)) in ('a', 'e', 'i', 'o', 'u');

#11 Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
select distinct(city) from station where lower(right(city,1)) in ('a', 'e', 'i', 'o', 'u');

#12 Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select distinct(city) from station where lower(left(city,1)) not in ('a', 'e', 'i', 'o', 'u');

#13  Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
select distinct(city) from station where lower(right(city,1)) not in ('a', 'e', 'i', 'o', 'u');

#14 Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
select distinct(city) from station where lower(left(city,1)) not in ('a', 'e', 'i', 'o', 'u') or lower(right(city,1)) not in ('a', 'e', 'i', 'o', 'u');

#15 Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
select distinct(city) from station where lower(left(city,1)) not in ('a', 'e', 'i', 'o', 'u') and lower(right(city,1)) not in ('a', 'e', 'i', 'o', 'u');

#17 Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.
select p.product_name from product p join sales s on p.product_id = s.product_id where s.sale_date between `2019-01-01` and `2019-03-31`;
