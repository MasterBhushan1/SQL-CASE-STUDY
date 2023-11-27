-- SWIGGY CASE STUDY --
Use swiggy;

-- Q1.  Find customers who have never ordered--

Select name
from users
where user_id  not in  (select User_id from orders);

-- Q2. Average Price/dish --

SELECT f.f_name, AVG(price) as "AVG_Price"
from menu m join food f
on f.f_id = m.f_id
group by f.f_name
order by AVG_Price DESC;

-- Q3. Find the top restaurant in terms of the number of orders for a given month--

SELECT R.r_name, Count(*) AS MONTHS_ORDERS
FROM ORDERS as O join restaurants R 
on O.r_id=R.r_id
WHERE monthname(DATE) LIKE "MAY"
GROUP BY R.r_name
ORDER BY Count(*) desc Limit 3 ;

-- Q4. restaurants with monthly sales greater than x for

SELECT R.r_name, SUM(AMOUNT)
FROM orders O 
JOIN restaurants R 
ON O.r_id=R.r_id
WHERE monthname(DATE) LIKE "JULY"
group by R.r_name
HAVING SUM(AMOUNT) > 500 ;

-- Q5. Show all orders with order details for a particular customer in a particular date range

SELECT o.order_id, R.r_name,  f.f_name
FROM orders o 
join order_details od 
on o.order_id=od.order_id
join food f 
on f.f_id=od.f_id
join restaurants R
on o.r_id=R.r_id
WHERE user_id IN (SELECT user_id FROM users where name like "Ankit")
And (date >= '2022-05-30' and date <= '2022-06-30');

-- Q6. Find restaurants with max repeated customers 

select r.r_name , count(*) as "Loyal_Customer" 
from 
(SELECT r_id, user_id, COUNT(*) AS "VISITS"
FROM ORDERS
group by  r_id, user_id
HAVING VISITS > 1) as T
join restaurants r
on T.r_id=r.r_id
Group by r.r_name
order by Loyal_Customer desc limit 1;

 -- Q.7 Month over month revenue growth of swiggy

select month, ((Revenue-Lag_revenue)/Lag_revenue)*100 AS Growth_Per from
(with sales as
 (
	select monthname(date) as "month", sum(amount) as Revenue
	from orders
	group by  month
	order by monthname(date) 
)
select month, Revenue, (lag(Revenue,1) over(order by Revenue)) as Lag_revenue from sales
) AS s;

-- Q.8. Customer - favorite food

with temp as (
	select o.user_id , od.f_id, count(*) as "frequency"
	from orders o 
	join order_details od 
	on o.order_id=od.order_id
	group by o.user_id , od.f_id
	)
select u.name, f.f_name from temp t1 join users u on u.user_id=t1.user_id join food f on f.f_id=t1.f_id
where t1.frequency = (select max(frequency) from temp t2 where t1.user_id=t2.user_id)