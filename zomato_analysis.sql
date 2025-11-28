CREATE DATABASE zomato_data;
USE zomato_data;
RENAME TABLE `order` TO `orders`;
SELECT * FROM orders ;

-- Find the top 5 restaurants with the highest total revenue after applying discounts.

SELECT restaurant_name,
SUM(order_value * (1 - discount_percent/100)) AS net_revenue
from orders
group by restaurant_name
order by net_revenue desc limit 5;

-- Cuisine with the highest average delivery time

select cuisine, avg(delivery_time_min) as avg_delivery_time
from orders
group by cuisine
order by avg_delivery_time desc limit 1;

-- Find top 3 fastest delivery partners per city.

with ranked_partners as(
   select delivery_city, delivery_partner,
   Round(avg(delivery_time_min),2) as avg_delivery_time,
   ROW_NUMBER() OVER(
      Partition by delivery_city
      order by avg(delivery_time_min)
   ) as ranks
   from orders
   group by delivery_city,delivery_partner
)
select * from ranked_partners
where ranks <=3;

-- Restaurants with highest cancellation rate.

select restaurant_name,
count(*) as total_orders,
sum(cancellation_reason <> 'No cancellation') AS cancelled_orders,
(SUM(cancellation_reason <> 'No cancellation') / count(*))*100 AS cancel_rate_percent
from orders
group by restaurant_name
order by cancel_rate_percent DESC;

-- Order volume + average order value per weekday

select order_day,
count(*) as total_order,
round(avg(order_value),2) as avg_order_value
from orders
group by order_day
order by total_order desc;

-- Top 5 most ordered foot items

select food_items,
count(*) as total_order
from orders
group by food_items
order by total_order desc limit 5;

-- Find the top 5 restaurants whose ratings increased the most after applying discounts.

with no_discount as(
   Select restaurant_name,
   avg(rating) as rating_no_discount
   from orders
   where discount_percent =0
   group by restaurant_name
),
with_discount as(
select restaurant_name,
avg(rating) as rating_with_discount
from orders
where discount_percent>0
group by restaurant_name
)
select w.restaurant_name,
w.rating_with_discount - n.rating_no_discount as rating_increase
from with_discount w
join no_discount n using (restaurant_name)
order by rating_increase desc
limit 5;

-- Cuisine delivery time analysis.

select cuisine,
round(avg(delivery_time_min),2) as avg_delivery_time
from orders
group by cuisine
order by avg_delivery_time desc;

-- Find the hour with the most high-value orders.

with avg_value as(
   select avg(order_value) as global_avg
   from orders
)
select hour(order_datetime) as order_hour,
count(*) as number_of_orders,
round(sum(order_value),2) as total_value_in_hour
from orders
cross join avg_value
where order_value>global_avg
group by hour(order_datetime)
order by number_of_orders desc;

-- Total money saved by customers due to discounts

select sum(order_value * discount_percent/100) as total_discount_amount
from orders;

-- Restaurants that gained most new customers in last 30 days.

with first_order as (
   select customer_id,
   restaurant_name,
   min(order_datetime) as first_order_date
   from orders
   group by customer_id, restaurant_name
)
select restaurant_name,
count(*) as new_customers
from first_order
where first_order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY restaurant_name
order by new_customers desc limit 10;