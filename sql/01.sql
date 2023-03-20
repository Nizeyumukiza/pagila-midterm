/*
 * You want to watch a movie tonight.
 * But you're superstitious,
 * and don't want anything to do with the letter 'F'.
 *
 * Write a SQL query that lists the titles of all movies that:
 * 1) do not have the letter 'F' in their title,
 * 2) have no actors with the letter 'F' in their names (first or last),
 * 3) have never been rented by a customer with the letter 'F' in their names (first or last).
 * 4) have never been rented by anyone with an 'F' in their address (at the street, city, or country level).
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */

/* 1) titles that do not have 'F' in their title" */

with no_f_in_title as (
    select title
    from film
    where title not ilike '%f%'
),

/* 2) title have actors with the letter 'F' in their names (first or last)*/

f_in_actor as (
    select distinct (title)
    from film
    join film_actor using(film_id)
    join actor using(actor_id)
    where first_name ilike '%f%' or last_name ilike '%f%'
),

/* 3) titles have been rented by a customer with the letter 'F' in their names (first or last).*/

f_in_customer as (
    select distinct(title)
    from film
    join inventory using(film_id)
    join rental using(inventory_id)
    join customer using(customer_id)
    where first_name ilike '%f%' or last_name ilike '%f%'
),

/*4) titles have  been rented by anyone with an 'F' in their address (at the street, city, or country level).*/

f_in_address as (
    select distinct (title)
    from film
    join inventory using(film_id)
    join rental using(inventory_id)
    join customer using(customer_id)
    join address using(address_id)
    join city using(city_id)
    join country using(country_id)
    where address ilike '%f%' or
          address ilike '%f%' or
          city ilike '%f%' or
          country ilike '%f%'
)

/* final answer */

select *
from no_f_in_title
where title not in (
    select title
    from f_in_actor
    natural full join f_in_customer
    natural full join f_in_address
);
