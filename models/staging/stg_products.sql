-- Staging: products
with source as (
    select * from {{ ref('raw_products') }}
),

renamed as (
    select
        product_id,
        trim(product_name) as product_name,
        trim(category) as category,
        cast(price as decimal(12, 2)) as price
    from source
)

select * from renamed