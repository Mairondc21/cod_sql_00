SELECT SUM((o.unit_price * o.quantity) * (1 - o.discount)) as total_price
FROM order_details o
JOIN orders os ON o.order_id = os.order_id
WHERE date_part('year',os.order_date) = 1997;

WITH ReceitasMensais AS (
    SELECT 
        EXTRACT(YEAR FROM os.order_date) as Ano,
        EXTRACT(MONTH FROM os.order_date) as Mes,
        SUM((o.unit_price * o.quantity) * (1 - o.discount)) as total_price
    FROM order_details o
    INNER JOIN orders os ON o.order_id = os.order_id   
    GROUP BY EXTRACT(YEAR FROM os.order_date), EXTRACT(MONTH FROM os.order_date)
)
SELECT * FROM ReceitasMensais;