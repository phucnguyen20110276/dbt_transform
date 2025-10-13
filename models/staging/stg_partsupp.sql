with partsupp as (
    select *
    from {{ source('source', 'partsupp') }}
)

select
  p_partkey as part_key,
  p_suppkey as supplier_key,
  p_availqty as available_quantity,
  p_supplycost as supply_cost
from partsupp
