-- Dimension: one row per product
with products as (
    select * from {{ ref('stg_products') }}
),

final as (
    select
        product_id,
        product_name,
        category,
        price,
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_key
    from products
)

select * from final