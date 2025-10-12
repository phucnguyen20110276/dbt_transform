with lineitem as (
    select *
    from {{ source('source', 'lineitem') }}
)

select 
  l_orderkey as order_key,
  l_lineitem as lineitem
from lineitem