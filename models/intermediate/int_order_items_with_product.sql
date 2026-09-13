-- One row per order line with product and order context
with order_items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

orders as (
    select order_id, customer_id, order_date, status
    from {{ ref('stg_orders') }}
),

joined as (
    select
        order_items.order_item_id,
        order_items.order_id,
        order_items.product_id,
        order_items.quantity,
        order_items.unit_price,
        (order_items.quantity * order_items.unit_price) as line_total,
        products.product_name,
        products.category as product_category,
        products.price as product_current_price,
        orders.customer_id,
        orders.order_date,
        orders.status as order_status
    from order_items
    left join products on order_items.product_id = products.product_id
    left join orders on order_items.order_id = orders.order_id
)

select * from joined