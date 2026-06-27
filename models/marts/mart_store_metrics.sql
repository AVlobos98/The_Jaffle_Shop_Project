WITH source AS (
    SELECT *
    FROM {{ ref('fct_orders') }}
),

final as (SELECT 
    store_id,
    store_name,
    year,
    end_of_month,
    sum(subtotal) AS subtotal,
    sum(tax_paid) AS tax_paid,
    sum(order_total) AS Revenue,
    cast(avg(order_total) AS INT) AS average_ticket,
    count(*) AS order_count,
    COUNT(DISTINCT customer_id) AS unique_customers,
    CAST((sum(order_total)/(COUNT(DISTINCT customer_id))) AS INT) AS avg_revenue_per_customer
FROM source
GROUP BY 
    store_id, store_name, end_of_month, year)

SELECT * FROM final
ORDER BY 
    end_of_month DESC