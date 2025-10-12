with customer as (
    select *
    from {{ source('source', 'customer') }}
)

select
    c_custkey as customer_key,
    c_nationkey as nation_key,
    c_mktsegment as market_segmentation
from customer
