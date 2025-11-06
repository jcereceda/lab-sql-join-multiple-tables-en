-- 1. Write a query to display for each store its store ID, city, and country
select 
	s.store_id,
    c.city,
    co.country
from 
	store s
    inner join address a on s.address_id = a.address_id
    inner join city c on a.city_id = c.city_id
    inner join country co on c.country_id = co.country_id;
    
-- 2. Write a query to display how much business, in dollars, each store brought in.

select
	s.store_id,
    sum(p.amount) as "total $ per store"
from 
	store s
    left join staff sf on s.store_id = sf.store_id
    left join payment p on p.staff_id = sf.staff_id
group by s.store_id;

-- 3. What is the average running time of films by category?
select
	c.name as category,
	round((f.length),2) as "Average length"
from 
	film f
    left join film_category fc on f.film_id = fc.category_id
    inner join category c on fc.category_id = c.category_id
group by c.category_id;

-- 4. Which film categories are longest?
select
	c.name as category,
	round((f.length),2) as "Average length"
from 
	film f
    left join film_category fc on f.film_id = fc.category_id
    inner join category c on fc.category_id = c.category_id
group by c.category_id
ORDER BY 2 DESC
LIMIT 5;

-- 5. Display the most frequently rented movies in descending order.

SELECT * FROM INVENTORY;
SELECT
	i.film_id,
    f.title,
    count(i.film_id) as "Nº of rents"
FROM 
	RENTAL R
    INNER JOIN INVENTORY I ON R.INVENTORY_ID = I.INVENTORY_ID
    inner join film f on i.film_id = f.film_id
group by i.film_id
order by 3 desc;

-- 6. List the top five genres in gross revenue in descending order.
select 
	c.name as "Genre",
    sum(p.amount) as "Total revenue $"
from 
	category c
    left join film_category fc on fc.category_id = c.category_id
    inner join film f on fc.film_id = f.film_id
    inner join inventory i on i.film_id = f.film_id
    inner join rental r on i.inventory_id = r.inventory_id
    inner join payment p on p.rental_id = r.rental_id
group by c.category_id
order by 2 desc
limit 5
;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select exists (
	select 1 from film f where
    upper(f.title) = upper("Academy Dinosaur")
    and f.film_id in (select distinct i.film_id from inventory i where store_id = 1)
) as "exists"
