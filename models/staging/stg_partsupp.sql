with partsupp as (
    select *
    from {{ source('source', 'partsupp') }}
)

select
  ps_partkey as part_key,
  ps_suppkey as supplier_key,
  ps_availqty as available_quantity,
  ps_supplycost as supply_cost
from partsupp
