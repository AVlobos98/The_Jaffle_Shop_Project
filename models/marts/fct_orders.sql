WITH source AS ( 
    SELECT * FROM {{ ref('int_order_summary') }}
),

final AS (
    SELECT 
       *,
       LAST_DAY(ordered_at, MONTH) AS end_of_month,
       extract(year from ordered_at) AS year
FROM source
)

SELECT * FROM final