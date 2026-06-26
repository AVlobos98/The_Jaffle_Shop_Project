WITH orders AS ( 
    SELECT * FROM {{ ref('stg_jaffle_shop__orders') }}
),

customers AS ( 
    SELECT * FROM {{ ref('stg_jaffle_shop__customers') }}
),

stores AS ( 
    SELECT * FROM {{ ref('stg_jaffle_shop__stores') }}
),


final AS (
    SELECT 
        o.*,
        c.customer_name,
        s.store_name
    FROM orders o
    LEFT JOIN customers c 
        ON o.customer_id = c.customer_id
    LEFT JOIN stores s 
        ON o.store_id = s.store_id

)

SELECT * FROM final