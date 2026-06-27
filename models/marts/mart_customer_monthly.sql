WITH source AS (
    SELECT *
    FROM {{ ref('fct_orders') }}
),

final AS (
    SELECT 
       customer_id,
       customer_name,
       end_of_month,
       year,
       SUM(subtotal) AS subtotal,
       SUM(tax_paid) AS tax_paid,
       SUM(order_total) AS total_revenue,
       cast(avg(order_total) AS INT) AS average_ticket,
       count(*) AS order_count
    FROM source
    GROUP BY 
        customer_id,
        customer_name,
        end_of_month,
        year
)

SELECT * FROM final