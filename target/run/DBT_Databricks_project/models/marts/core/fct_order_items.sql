-- back compat for old kwarg name
  
  
  
  
  
  
      
          
          
      
  

    merge
    into
        `workspace`.`gold`.`fct_order_items` as DBT_INTERNAL_DEST
    using
        `fct_order_items__dbt_tmp` as DBT_INTERNAL_SOURCE
    on
        
              DBT_INTERNAL_SOURCE.`order_item_id` <=> DBT_INTERNAL_DEST.`order_item_id`
          
    when matched
        then update set
            `quantity` = DBT_INTERNAL_SOURCE.`quantity`, `unit_price` = DBT_INTERNAL_SOURCE.`unit_price`, `revenue` = DBT_INTERNAL_SOURCE.`revenue`, `order_status` = DBT_INTERNAL_SOURCE.`order_status`
    when not matched
        then insert
            *
