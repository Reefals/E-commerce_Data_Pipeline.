-- Fact: one row per order line (incremental)


with line_items as (
    select * from `workspace`.`silver`.`int_order_items_with_product`
    
    where order_date > (select max(order_date) from `workspace`.`gold`.`fct_order_items`)
    
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