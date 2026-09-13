
  
  
  
  create or replace view `workspace`.`silver`.`stg_orders`
  
  as (
    -- Staging: orders
with source as (
    select * from `workspace`.`bronze`.`raw_orders`
),

renamed as (
    select
        order_id,
        customer_id,
        cast(order_date as date) as order_date,
        lower(trim(status)) as status,
        cast(total_amount as decimal(12, 2)) as total_amount
    from source
)

select * from renamed
  )
