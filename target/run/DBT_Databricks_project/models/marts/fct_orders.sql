
  
    
        create or replace table `workspace`.`gold`.`fct_orders`
      
      
    using delta
  
      
      
      
      
      
      
      
      
      as
      -- Fact: one row per order (incremental)


with orders_enriched as (
    select * from `workspace`.`silver`.`int_orders_enriched`
    
),

final as (
    select
        order_id,
        customer_id,
        order_date,
        status,
        order_total_amount as revenue,
        line_count as number_of_lines,
        total_quantity as total_units,
        customer_country,
        md5(cast(concat(coalesce(cast(order_id as string), '_dbt_utils_surrogate_key_null_')) as string)) as order_key
    from orders_enriched
)

select * from final
  