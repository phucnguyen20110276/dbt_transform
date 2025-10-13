-- depends_on: {{ ref('stg_lineitem') }}

{{
  config(
    materialized = 'incremental',
    unique_key = 'lineitem_key',
    cluster_by = ['order_key'],
    incremental_strategy = 'merge',
    on_schema_change = 'fail'
  )
}}

with lineitem as (
  select *
  from {{ ref('stg_lineitem') }}
)

select
  {{ dbt_utils.generate_surrogate_key(['order_key', 'line_number']) }} as lineitem_key,
  order_key,
  part_key,
  supplier_key,
  quantity,
  extended_price,
  discount,
  tax,
  return_flag,
  line_status,
  ship_date,
  commit_date,
  receipt_date,
  ship_mode
from lineitem
{% if is_incremental() %}
  where order_key > (select max(order_key) from {{ this }})
{% endif %}
