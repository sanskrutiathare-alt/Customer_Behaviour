SELECT * FROM customer limit 20;
SELECT gender, SUM(purchase_amount) as revenue from customer GROUP BY gender;
SELECT customer_id, purchase_amount FROM customer WHERE discount_applied= 'YES' AND purchase_amount>=(select AVG(purchase_amount) FROM customer);
SELECT item_purchased, ROUND(AVG(review_rating),2) AS "average_rating" FROM Customer GROUP BY item_purchased order by average_rating DESC LIMIT 5;
SELECT avg(purchase_amount) as avrg ,shipping_type FROM customer WHERE shipping_type in ('Standard','Express') GROUP BY shipping_type;
-- Do subscribed customers spend more ? compare average spend and totAL REVENUE BETWEEN SUBSCrIBERS AND NON SUBSCRIBERS
SELECT subscription_status, count(customer_id),AVG(purchase_amount),sum(purchase_amount) FROM customer GROUP BY subscription_status;
SELECT item_purchased, SUM(CASE WHEN discount_applied ='Yes' THEN 1 ELSE 0 END) /COUNT(*) *100  as discount_rate FROM customer GROUP BY item_purchased limit 5;
-- segmentation
WITH customer_type AS(
SELECT customer_id, previous_purchases, CASE WHEN previous_purchases=1 THEN 'New'
WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
ELSE 'Loyal'
END AS customer_segment
From customer)

SELECT  customer_segment, count(customer_id) as 'Number of customers'
FROM customer_type
Group by customer_segment;


-- ADvanced query
with item_count AS(
select category,
 item_purchased, 
 COUNT(customer_id) as total_orders, ROW_NUMBER() over (partition by category order by count(customer_id) DESC) as item_rank
 From customer group by category ,item_purchased)
select item_rank, category, item_purchased, total_orders from item_count where item_rank<=3; 
-- are customers who are repeat buyers(more than 5 previous purchases also likely to subscribe)
Select subscription_status, count(customer_id) AS repeat_buyers FROM customer WHERE previous_purchases > 5 GROUP BY subscription_status;
-- what is the revenue contribution of each age group
select age_group, sum(purchase_amount) as total_revenue from customer group by age_group order by total_revenue desc;

 


