with part as (
    select *
    from {{ source('source', 'part') }}
)

select
  p_partkey as part_key,
  p_suppkey as supplier_key,
  p_supplycost as supply_cost
from part