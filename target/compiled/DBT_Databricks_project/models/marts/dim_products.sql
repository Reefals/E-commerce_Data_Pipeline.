-- Dimension: one row per product
with products as (
    select * from `workspace`.`silver`.`stg_products`
),

final as (
    select
        product_id,
        product_name,
        category,
        price,
        md5(cast(concat(coalesce(cast(product_id as string), '_dbt_utils_surrogate_key_null_')) as string)) as product_key
    from products
)

select * from final