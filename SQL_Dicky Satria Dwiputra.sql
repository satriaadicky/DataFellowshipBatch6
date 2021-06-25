-- 1. How many film recommendation about astronaut?
select COUNT(*) 
from film 
where description like '%Astronaut%'

-- 2. how many films have a rating of “R” and a replacement cost between $5 and $15?
select count(*) 
from film
where rating = 'R' and replacement_cost between 5 and 15

-- 3. -	We have two staff members with staff IDs 1 and 2. 
-- We want to give a bonus to the staff member that handled the most payments.
-- How many payments did each staff member handle? And how much was the total amount processed by each staff member?
select concat(s.first_name,' ',s.last_name) fullName, COUNT(p.payment_id) number_of_Payment, SUM(p.amount) Amount 
from payment p 
join staff s 
using(staff_id)
group by fullName

-- 4. Corporate headquarters is auditing the store! They want to know the average replacement cost of movies by rating!
select rating, ROUND(AVG(replacement_cost), 2) avg_Replacement_Cost 
from film f 
group by rating
order by avg_Replacement_Cost desc

-- 5. We want to send coupons to the 5 customers who have spent the most amount of money. 
-- Get the customer name, email and their spent amount!
select concat(c.first_name, ' ', c.last_name) fullname, c.email, sum(p.amount) amount
from customer c 
join payment p 
using(customer_id)
group by fullname, email 
order by amount desc 
limit 5

-- 6. We want to audit our stock of films in all of our stores. 
-- How many copies of each movie in each store, do we have?
select film_id, store_id, count(film_id) copies_of_film 
from inventory i
group by store_id, film_id 
order by film_id 

-- 7. -	We want to know what customers are eligible for our platinum credit card. 
-- The requirements are that the customer has at least a total of 40 transaction payments. 
-- Get the customer name, email who are eligible for the credit card!
select fullname, email 
from (select concat(c.first_name, ' ', c.last_name) fullname, c.email, count(p.payment_id) number_of_payment_transactions
from customer c 
join payment p 
using(customer_id)
group by fullname, email) q
where number_of_payment_transactions >= 40