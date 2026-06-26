WITH source AS ( 
    SELECT * FROM {{ ref('raw_customers')}}
),

final AS (SELECT
    id AS customer_id,
    name AS customer_name
FROM source)

SELECT * FROM final