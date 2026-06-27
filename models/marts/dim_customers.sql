WITH source AS (
    SELECT * FROM {{ ref('fct_orders') }}
),

aggregated AS (
    SELECT 
        customer_id,
        customer_name,
        MIN(ordered_at) AS first_order_date,
        MAX(ordered_at) AS last_order_date,
        DATE_DIFF(MAX(ordered_at), MIN(ordered_at), DAY) AS customer_lifespan_days,
        SUM(subtotal) AS subtotal,
        SUM(tax_paid) AS tax_paid,
        SUM(order_total) AS total_revenue,
        COUNT(DISTINCT DATE_TRUNC(ordered_at, MONTH)) AS distinct_months_ordered,
        CAST(AVG(order_total) AS INT) AS average_ticket,
        COUNT(*) AS order_count
    FROM source
    GROUP BY customer_id, customer_name
),

final AS (
    SELECT
        *,
        CAST(CAST(total_revenue AS FLOAT64) / NULLIF(customer_lifespan_days, 0) AS INT) AS revenue_per_day,
    FROM aggregated
)

SELECT * FROM final