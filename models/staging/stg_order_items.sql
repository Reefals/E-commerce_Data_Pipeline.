-- Staging: order line items
with source as (
    select * from {{ ref('raw_order_items') }}
),

renamed as (
    select
        order_item_id,
        order_id,
        product_id,
        cast(quantity as int) as quantity,
        cast(unit_price as decimal(12, 2)) as unit_price
    from source
)

select * from renamed