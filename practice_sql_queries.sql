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

#6 Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
select DISTINCT district from city where countrycode='JPN';

#7  Query a list of CITY and STATE from the STATION table.
select * from station;

#8 Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
select distinct(city) from station where id in (select id from station where mod(id,2) = 0);

#9  Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table. 
select (count(city) - count(distinct(city))) from station;

#10 Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
select city, char_length(city) from station where char_length(city) = (select min(char_length(city)) as min_city_length from station) order by city limit 1;

#11 Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
select distinct(city) from station where lower(left(city,1)) in ('a', 'e', 'i', 'o', 'u');

#12 Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
select distinct(city) from station where lower(right(city,1)) in ('a', 'e', 'i', 'o', 'u');

#13 Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select distinct(city) from station where lower(left(city,1)) not in ('a', 'e', 'i', 'o', 'u');

#14  Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
select distinct(city) from station where lower(right(city,1)) not in ('a', 'e', 'i', 'o', 'u');

#15 Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
select distinct(city) from station where lower(left(city,1)) not in ('a', 'e', 'i', 'o', 'u') or lower(right(city,1)) not in ('a', 'e', 'i', 'o', 'u');

#16 Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
select distinct(city) from station where lower(left(city,1)) not in ('a', 'e', 'i', 'o', 'u') and lower(right(city,1)) not in ('a', 'e', 'i', 'o', 'u');

#17 Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.
select product_id, product_name 
from product
where product_id not in (select product_id 
                        from sales
                        where sale_date not BETWEEN
                        '2019-01-01' and '2019-03-31');


#18 Write an SQL query to find all the authors that viewed at least one of their own articles. Return the result table sorted by id in ascending order.
select DISTINCT author_id 
from Views 
where author_id = viewer_id
order by author_id asc;

#19 Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.
select ROUND(count(*) / (select count(*) from Delivery) * 100, 2) immediate_percentage
from Delivery
where order_date = customer_pref_delivery_date;


#20 Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
-- Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.
select ad_id, 
ifnull(
    round(
            avg(
            case 
                when action = 'Clicked' then 1
                when action = 'Viewed' then 0
                else NULL
            end
        ) * 100,
    2),
0) ctr
from ads
group by ad_id
order by ctr desc;


#21 Write an SQL query to find the team size of each of the employees. Return result table in any order.
select e1.employee_id, count(e2.employee_id) as team_size 
from `EMPLOYEE` e1
inner join `EMPLOYEE` e2 on e1.team_id = e2.team_id
GROUP BY e1.employee_id, e2.team_id;

#22 Write an SQL query to find the type of weather in each country for November 2019. The type of weather is:
-- ● Cold if the average weather_state is less than or equal 15,
-- ● Hot if the average weather_state is greater than or equal to 25, and
-- ● Warm otherwise.
-- Return result table in any order.
select ctry.country_name, (
    CASE 
        WHEN avg(wthr.weather_state) <= 15 THEN 'Cold'
        WHEN avg(wthr.weather_state) >= 25 THEN 'Hot'
        ELSE 'Warm'
    END
) as weather_type
from countries ctry 
join weather wthr 
on ctry.country_id = wthr.country_id
where EXTRACT(YEAR_MONTH from wthr.day) = '201911'
group by ctry.country_name;


# ========== @@@@@@@@ ==========


#51 Write an SQL query to report the name, population, and area of the big countries.
select name, population, area from World where area >= 3000000 or population >= 25000000;

#52 Write an SQL query to report the names of the customer that are not referred by the customer with id = 2.
-- Return the result table in any order.
select name from customer where referee_id != 2 or referee_id is Null

#53 Write an SQL query to report all customers who never order anything. Return the result table in any order.
select name as Customers from Customers where id not in (select customerId from Orders);

#54 Write an SQL query to find the team size of each of the employees.
select e1.employee_id, count(e2.employee_id) as team_size
from Employee e1
inner join Employee e2
on e1.team_id = e2.team_id
group by e1.employee_id, e2.team_id


#55 Write an SQL query to find the countries where this company can invest
select c.name as country 
from Person p 
inner join Country c 
on left (p.phone_number,3) = c.country_code 
inner join (select caller_id as id, duration 
            from Calls 
            
            union all 
            
            select callee_id as id, duration 
            from Calls) phn 
on p.id = phn.id 
group by country 
having avg(duration) > (select avg(duration) from Calls)


#56 Write an SQL query to report the device that is first logged in for each player.
select player_id, device_id from Activity
group by player_id

#57 Write an SQL query to find the customer_number for the customer who has placed the largest number of orders.
select customer_number from Orders
group by customer_number
order by count(order_number) desc
limit 1;

#Followup Question: What if more than one customer has the largest number of orders, can you find all the customer_number in this case?
select customer_number from Orders
group by customer_number
order by count(order_number) desc;


# 58 Write an SQL query to report all the consecutive available seats in the cinema.
# Return the result table ordered by seat_id in ascending order.
select distinct c1.seat_id
from cinema c1 join cinema c2
    on abs(c1.seat_id - c2.seat_id) = 1
    and c1.free = true and c2.free = true
order by c1.seat_id
;


#59 Write an SQL query to report the names of all the salespersons who did not have any orders related to the company with the name "RED".
select name 
from salesperson 
where sales_id not in (
    select sales_id 
    from orders 
    where com_id in (
        select com_id 
        from Company 
        where name = "RED"));

#60 Write an SQL query to report for every three line segments whether they can form a triangle.
select x, y, z, (
    CASE 
        WHEN abs(x+y) > abs(z) and abs(y+z) > abs(x) and abs(x+z) > abs(y) THEN 'Yes' 
        ELSE 'No'
    END
) as triangle
from Triangle
group by x,y,z
