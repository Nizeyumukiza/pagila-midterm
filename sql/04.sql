/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query SELECT query that:
 * Lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 * (You may choose to either include or exclude the movie 'AMERICAN CIRCUS' in the results.)
 */

/* all actors who acted in 'AMERICAN CIRCUS' */

with actors_in_am_circus as (
    select first_name || ' ' || last_name as "actor_name"
    from (select * from film where title = 'AMERICAN CIRCUS') as t
    join film_actor using(film_id)
    join actor using(actor_id)
)

/* final result: including 'AMERICAN CIRCUS' */
select title
from film
join film_actor using(film_id)
join actor using(actor_id)
where first_name || ' ' || last_name in (
    select *
    from actors_in_am_circus
)
group by title
having count(*) >= 2
order by title;
