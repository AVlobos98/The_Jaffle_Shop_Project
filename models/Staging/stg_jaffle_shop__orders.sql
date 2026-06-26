WITH source AS ( 
    SELECT * FROM {{ ref('raw_orders')}}
),

final AS (SELECT
    id AS order_id,
    customer AS customer_id,
    CAST(ordered_at AS DATE) AS ordered_at,
    store_id,
    subtotal,
    tax_paid,
    order_total
FROM source)

SELECT * FROM final