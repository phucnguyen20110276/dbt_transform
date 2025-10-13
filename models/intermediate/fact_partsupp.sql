-- depends_on: {{ ref('stg_partsupp') }}

{{
  config(
    materialized = 'incremental',
    unique_key = 'partsupp_key',
    incremental_strategy = 'merge',
    on_schema_change = 'fail'
  )
}}

with partsupp as (
  select *
  from {{ ref('stg_partsupp') }}
)

select
  {{ dbt_utils.generate_surrogate_key(['part_key', 'supplier_key']) }} as partsupp_key,
  part_key,
  supplier_key,
  available_quantity,
  supply_cost
from partsupp
