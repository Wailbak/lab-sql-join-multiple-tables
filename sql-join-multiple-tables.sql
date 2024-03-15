USE sakila;



-- Writing a query to display for each store its store ID, city, and country.
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM 
    store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

--------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Writing a query to display how much business, in dollars, each store brought in.
SELECT 
    i.store_id, 
    SUM(p.amount) AS total_sales
FROM 
    payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY 
    i.store_id
ORDER BY 
    total_sales DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Determining the average running time of films by category.
SELECT 
    c.name AS Category, 
    ROUND(AVG(f.length), 2) AS Average_Running_Time
FROM 
    film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    Average_Running_Time DESC;

-------------------------------------------------------------------------------------------------------------------------------------------------------

-- Identifying which film categories are longest.

SELECT 
    c.name AS Category, 
    ROUND(AVG(f.length), 2) AS Average_Running_Time
FROM 
    film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    Average_Running_Time DESC;
    
---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Displaying the most frequently rented movies in descending order.

SELECT 
    f.title AS Film_Title, 
    COUNT(r.rental_id) AS Rental_Count
FROM 
    rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY 
    f.title
ORDER BY 
    Rental_Count DESC, 
    Film_Title;

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Listing the top five genres in gross revenue in descending order.

SELECT 
    c.name AS Genre, 
    SUM(p.amount) AS Total_Revenue
FROM 
    payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    Total_Revenue DESC
LIMIT 5;

---------------------------------------------------------------------------------------------------------------------------------------------

-- Checking if "Academy Dinosaur" is available for rent from Store 1.

SELECT 
    f.title, 
    i.store_id, 
    COUNT(i.inventory_id) AS Available_Copies
FROM 
    film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE 
    f.title = 'ACADEMY DINOSAUR' 
    AND i.store_id = 1
GROUP BY 
    f.title, i.store_id;













































