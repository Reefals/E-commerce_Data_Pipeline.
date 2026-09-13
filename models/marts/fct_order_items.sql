-- Fact: one row per order line (incremental)
{{
    config(
      materialized='incremental',
      unique_key='order_item_id',
      merge_update_columns=['quantity', 'unit_price', 'revenue', 'order_status'],
    )
}}

with line_items as (
    select * from {{ ref('int_order_items_with_product') }}
    {% if is_incremental() %}
    where order_date > (select max(order_date) from {{ this }})
    {% endif %}
),

final as (
    select
        order_item_id,
        order_id,
        product_id,
        quantity,
        unit_price,
        line_total as revenue,
        product_name,
        product_category,
        customer_id,
        order_date,
        order_status
    from line_items
)

select * from final