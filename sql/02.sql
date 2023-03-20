/*
 * Write a SQL query SELECT query that:
 * computes the country with the most customers in it. 
 */

with country_customer_count as (
    select country, count(customer_id) as "total_customers"
    from customer
    join address using(address_id)
    join city using(city_id)
    join country using(country_id)
    group by country
    order by total_customers desc
)

select country
from country_customer_count
limit 1;
