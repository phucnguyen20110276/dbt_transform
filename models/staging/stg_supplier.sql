with supplier as (
    select *
    from {{ source('source', 'supplier') }}
)

select
  s_suppkey as supplier_key,
  s_nationkey as nation_key
from supplier
