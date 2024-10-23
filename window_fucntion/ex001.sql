-- Active: 1729274900293@@127.0.0.1@5432@my_db

SELECT 
    order_id,
    COUNT( order_id) AS total_product,
    SUM(quantity) AS total_quantity,
    SUM(unit_price * quantity) as total
FROM order_details
GROUP BY order_id,quantity
ORDER BY order_id;

SELECT 
    DISTINCT order_id,
    COUNT(order_id) OVER (PARTITION BY  order_id) AS total_product,
    SUM(quantity) OVER (PARTITION BY  order_id) AS total_quantity,
    SUM(unit_price * quantity) OVER (PARTITION BY  quantity) as total
FROM order_details
ORDER BY order_id;

SELECT 
    customer_id,
    MIN(freight),
    AVG(freight),
    MAX(freight)
FROM orders
GROUP BY customer_id
ORDER BY customer_id;

SELECT 
    DISTINCT customer_id,
    MIN(freight) OVER (PARTITION BY customer_id) AS minimo,
    AVG(freight) OVER (PARTITION BY customer_id) AS media,
    MAX(freight) OVER (PARTITION BY customer_id) AS maximo
FROM orders
ORDER BY customer_id;

SELECT 
    o.order_id,
    p.product_name,
    (o.unit_price * o.quantity) AS total_vendas,
    ROW_NUMBER() OVER (PARTITION BY p.product_name ORDER BY (o.unit_price * o.quantity) DESC) AS order_rn, 
    RANK() OVER (PARTITION BY p.product_name ORDER BY (o.unit_price * o.quantity) DESC) AS order_rank, 
    DENSE_RANK() OVER (PARTITION BY p.product_name ORDER BY (o.unit_price * o.quantity) DESC) AS order_dense
FROM order_details o
JOIN products p ON p.product_id = o.product_id

SELECT first_name, last_name, title,
   NTILE(3) OVER (ORDER BY first_name) AS group_number
FROM employees;

SELECT 
  customer_id, 
  TO_CHAR(order_date, 'YYYY-MM-DD') AS order_date, 
  shippers.company_name AS shipper_name, 
  LAG(freight) OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS previous_order_freight, 
  freight AS order_freight, 
  LEAD(freight) OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS next_order_freight
FROM 
  orders
JOIN 
  shippers ON shippers.shipper_id = orders.ship_via;



