-- Fact: one row per order (incremental)
{{
    config(
      materialized='incremental',
      unique_key='order_id',
      merge_update_columns=['status', 'revenue', 'number_of_lines', 'total_units', 'customer_country'],
    )
}}

with orders_enriched as (
    select * from {{ ref('int_orders_enriched') }}
    {% if is_incremental() %}
    where order_date > (select max(order_date) from {{ this }})
    {% endif %}
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
        {{ dbt_utils.generate_surrogate_key(['order_id']) }} as order_key
    from orders_enriched
)

select * from final