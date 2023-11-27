# Swiggy SQL Case Study

![Swiggy Logo]((https://logosmarken.com/wp-content/uploads/2020/11/Swiggy-Zeichen.png))

## Introduction

Welcome to the Swiggy SQL Case Study repository! This project focuses on analyzing Swiggy's database using SQL queries to extract valuable insights into customer behavior, restaurant performance, and revenue growth.

## Database Schema

The database schema includes the following tables:

- **users:** Information about Swiggy users.
- **menu:** Details about the menu items offered by different restaurants.
- **food:** Specific food items and their details.
- **restaurants:** Information about the restaurants available on Swiggy.
- **orders:** Details of customer orders, including order ID, restaurant ID, user ID, and date.
- **order_details:** Information about the items included in each order, such as food ID and quantity.

## SQL Queries

### Q1. Find customers who have never ordered

```sql
-- SQL query for finding customers who have never ordered
SELECT name
FROM users
WHERE user_id NOT IN (SELECT user_id FROM orders);
