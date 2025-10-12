with orders as (
    select * 
    from {{ source('source', 'orders') }}
)

select
    o_orderkey as order_key,
    o_custkey as customer_key,
    o_orderstatus as order_status,
    o_totalprice as total_price,
    o_orderdate as order_date
from orders
