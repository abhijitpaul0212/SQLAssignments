-- @@@@@@@ --  

# Create a database 
CREATE DATABASE IF NOT EXISTS practice_sql;  

use practice_sql;

# Create product_info table
CREATE TABLE `product_info` (
    `id` int DEFAULT NULL,
    `name` varchar(30) DEFAULT NULL);

truncate table product_info;

# Import records to 'product_info' table from  product_info_table.csv into your MySQL database using MySQLWorkbench 

# Create product_likes table
CREATE TABLE `product_likes` (
    `user_id` int DEFAULT NULL,
    `prod_id` int DEFAULT NULL,
    `liked_dates` datetime DEFAULT NULL,
    KEY `pk_user_id` (`user_id`));

truncate table product_likes;

# Import records to 'product_likes' table from  product_likes_table.csv into your MySQL database using MySQLWorkbench 

# Query to return the ids of product_info that have Zero likes
select id from product_info where id not in (select prod_id from product_likes);
