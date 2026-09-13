
  
  
  
  create or replace view `workspace`.`silver`.`int_orders_enriched`
  
  as (
    -- One row per order with customer and order-item aggregates

with orders as (

    select * from `workspace`.`silver`.`stg_orders`

),

customers as (

    select * from `workspace`.`gold`.`scd_customers`
    where dbt_valid_to is null

),

order_items as (

    select
        order_id,
        count(*) as line_count,
        sum(quantity) as total_quantity,
        sum(quantity * unit_price) as line_total_amount
    from `workspace`.`silver`.`stg_order_items`
    group by order_id

),

joined as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        orders.total_amount as order_total_amount,

        customers.first_name as customer_first_name,
        customers.last_name as customer_last_name,
        customers.email as customer_email,
        customers.country as customer_country,
        customers.created_at as customer_created_at,

        coalesce(order_items.line_count, 0) as line_count,
        coalesce(order_items.total_quantity, 0) as total_quantity,
        coalesce(order_items.line_total_amount, 0) as line_total_amount

    from orders

    left join customers
        on orders.customer_id = customers.customer_id

    left join order_items
        on orders.order_id = order_items.order_id

)

select *
from joined
  )
