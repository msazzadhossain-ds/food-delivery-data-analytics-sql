# Q1. Retrieve a list of user information with their name and date of registration who uses android phones.

SELECT name AS user_name, registration_date   
FROM user_info 
WHERE operating_system = 'Android'; 

# Q2. Find out users who have registered on or after 14th of july and sort the list of users in ascending order.

SELECT name AS user_name
FROM user_info 
WHERE registration_date >= '2023-07-14' 
ORDER BY user_name;

# Q3. Retrieve a list of all restaurants and their menu items. Some restaurants may not have any menu items yet. 

SELECT a.name AS restaurant_name, b.name AS item_name 
FROM restaurant_info a
LEFT JOIN menuitems b
ON a.restaurant_id = b.restaurant_id;

/* Q4. Extend the previous result to include the restaurant's contact number and the availability status of each menu item.
If a restaurant does not have any menu items, display "No Menu Items" in the menu item column. */

SELECT a.name AS restaurant_name, COALESCE(b.name, 'No Menu Items') AS item_name, 
a.contact_number, b.availability 
FROM restaurant_info a
LEFT JOIN menuitems b
ON a.restaurant_id = b.restaurant_id;

# Q5. Retrieve the total number of orders placed by each user. Sort the results in descending order based on the number of orders. 

SELECT name AS user_name, COUNT(order_id) AS total_order
FROM user_info a
LEFT JOIN orders b
ON a.id = b.user_id
GROUP BY user_name
ORDER BY total_order desc;

# Q6. Find the average price of menu items for each restaurant. Sort the results in ascending order based on the restaurant name.

SELECT a.name AS restaurant_name, ROUND(AVG(b.price), 2) AS avg_menu_item_price
FROM restaurant_info a
LEFT JOIN menuitems b
ON a.restaurant_id = b.restaurant_id
GROUP BY restaurant_name
ORDER BY restaurant_name ASC;

# Q7. Identify the restaurant with the highest total sales (sum of order amounts). Display the restaurant name and the total sales amount.

SELECT a.name AS restaurant_name, SUM(b.total_amount) AS total_sales_amount
FROM restaurant_info a
LEFT JOIN orders b
ON a.restaurant_id = b.restaurant_id
GROUP BY restaurant_name
ORDER BY restaurant_name ASC;

# Q8. Find the number of orders placed in each city. Sort the results in descending order based on the number of orders.

SELECT a.city_name, COUNT(c.order_id) AS number_of_orders 
FROM city a
INNER JOIN user_info b
ON a.city_id = b.city_id 
INNER JOIN orders c
ON b.id = c.user_id 
GROUP BY city_name 
ORDER BY number_of_orders DESC;

# Q9. Find the names of restaurants that have at least one menu item with a price greater than $10.

SELECT DISTINCT a.name AS restaurant_name
FROM restaurant_info a
INNER JOIN menuitems b
ON a.restaurant_id = b.restaurant_id
WHERE b.price > 10
ORDER BY restaurant_name;

# Q10. Retrieve the user names and their corresponding orders where the order total is greater than the average order total for all users.

SELECT a.name AS user_name, b.order_count AS total_order 
FROM user_info a
INNER JOIN 
( 
	SELECT user_id, COUNT(order_id) AS order_count 
	FROM orders 
	GROUP BY user_id 
) AS b
ON a.id = b.user_id
WHERE b.order_count >
(
	SELECT AVG(ORDER_COUNT) 
	FROM 
	(
		SELECT user_id, COUNT(order_id) AS order_count 
		FROM orders 
		GROUP BY user_id 
	) AS c
); 

# Q11. List the names of users whose last names start with 'S' or ends with ‘e’.

SELECT name AS user_name  
FROM user_info 
WHERE SUBSTRING_INDEX(name, " ", -1) LIKE 'S%' OR SUBSTRING_INDEX(name, " ", -1) LIKE '%e';

# Q12. Find the total order amounts for each restaurant. If a restaurant has no orders, display the restaurant name and a total amount of 0.

SELECT a.name AS restaurant_name, 
COALESCE(COUNT(b.order_id), 0) AS total_order, 
COALESCE(SUM(b.total_amount), 0) AS total_order_amount 
FROM restaurant_info a 
LEFT JOIN orders b 
ON a.restaurant_id = b.restaurant_id 
GROUP BY restaurant_name;

# Q13. Find out how many orders were placed using cash or credit.

SELECT a.name AS payment_type_name, COUNT(b.order_id) AS order_quantity 
FROM payment_type a 
LEFT JOIN payment_transactions b 
ON a.pay_type_id = b.pay_type_id 
GROUP BY payment_type_name;



