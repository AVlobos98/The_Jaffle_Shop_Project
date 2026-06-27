WITH source AS ( 
    SELECT * FROM {{ ref('raw_stores')}}
),

final AS (
    SELECT
        id AS store_id,
        name AS store_name,
        CAST(opened_at AS DATE) AS opened_at,
        tax_rate
    FROM source)

SELECT * FROM final