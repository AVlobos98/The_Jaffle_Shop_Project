WITH orders AS ( 
    SELECT * FROM {{ ref('stg_jaffle_shop__orders') }}
),

customers AS ( 
    SELECT * FROM {{ ref('stg_jaffle_shop__customers') }}
),

final AS (
    SELECT 
        o.*,
        c.customer_name
    FROM orders o
    LEFT JOIN customers c 
        ON o.customer_id = c.customer_id

)

SELECT * FROM final