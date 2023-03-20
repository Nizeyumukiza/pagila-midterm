/*
 * Write a SQL query SELECT query that:
 * List the first and last names of all actors who have appeared in movies in the "Children" category,
 * but that have never appeared in movies in the "Horror" category.
 */

/* film_ids in "Children" category */

with ids_in_children as (
    select film_id
    from film_category
    join category using(category_id)
    where name = 'Children'
),

/* film_ids in "Horror" category */
ids_in_horror as (
    select film_id
    from film_category
    join category using(category_id)
    where name = 'Horror'
),

/* actors who appeared in movies under "Children" Category */

actors_in_children as (
   select distinct first_name, last_name
   from ids_in_children
   left join film using(film_id)
   join film_actor using(film_id)
   join actor using(actor_id)
),

/* actors who appeared in movies who appeared under "Horror" Category */

actors_in_horror as (
   select distinct first_name, last_name
   from ids_in_horror
   left join film using(film_id)
   join film_actor using(film_id)
   join actor using(actor_id)
)

/* final answer */

select distinct first_name, last_name
from actors_in_children as ac
natural left join actors_in_horror as ah
where ah.last_name is null and ah.first_name is null
order by first_name, last_name;
