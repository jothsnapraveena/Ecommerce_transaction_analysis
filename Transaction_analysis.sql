use ProjectPortfolio
--What are the unique brands available in the dataset?
select distinct brand
from transaction_dataset

--How many unique customers made transactions in the dataset?
select count(distinct customer_id)
from transaction_dataset

-- How many transactions were approved and how many were not approved?
select
sum(case when order_status='Approved' then 1 else 0 end) as approved_transactions,
sum(case when order_status<>'Approved' then 1 else 0 end) as NotApproved_transactions
from transaction_dataset

--List the top product lines with the highest average list price
select product_line,round(avg(list_price),2) as avg_list_price
from transaction_dataset
group by product_line
order by avg(list_price) desc

--List the product_id, list_price, and standard_cost of the products where the list_price is greater than twice the standard_cost.
select product_id,list_price,standard_cost
from transaction_dataset
where list_price>=2*standard_cost

--Which brand has the maximum difference between the list_price and standard_cost for their products?
select brand,max(list_price-standard_cost) as max_margin
from transaction_dataset
group by brand
order by max(list_price-standard_cost) desc

--List the customer_id and the count of their transactions, ordered by the number of transactions in descending order.
select customer_id,count(transaction_id) as transaction_count
from transaction_dataset
group by customer_id
order by count(transaction_id) desc

-- Find the total sales amount for each brand, sorted in descending order of total sales.¶
select brand,sum(list_price) as total_sales
from transaction_dataset
group by brand
order by sum(list_price) desc

--What are the top products with the highest profit margin.

select distinct product_id,brand,product_line,(list_price-standard_cost) as price_margin
from transaction_dataset
order by (list_price-standard_cost) desc

--For each customer, find the total number of transactions, the total amount they spent, and their average profit per transaction
select customer_id,count(distinct transaction_id) as total_transactions,sum(list_price) as total_amount_spent,
(avg(list_price)-avg(standard_cost)) as avg_profit_transaction
from transaction_dataset
group by customer_id

--Find the top 5 product lines with the highest total revenue and their percentage contribution to the overall revenue
select product_line,sum(list_price) as total_revenue,
(sum(list_price)*100/(select sum(list_price) from transaction_dataset)) as percentage_contribution
from transaction_dataset
group by product_line
order by sum(list_price) desc