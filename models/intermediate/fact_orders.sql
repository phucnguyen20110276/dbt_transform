-- depends_on: {{ ref('stg_orders') }}

{{
  config(
    materialized = 'incremental',
    unique_key = 'order_key',
    cluster_by = ['order_date'],
    incremental_strategy = 'merge',
    on_schema_change = 'fail'
  )
}}

with orders as (
  select *
  from {{ ref('stg_orders') }}
)

select
  order_key,
  customer_key,
  order_status,
  total_price,
  order_date
from orders
{% if is_incremental() %}
  where order_date > (select max(order_date) from {{ this }})
{% endif %}
