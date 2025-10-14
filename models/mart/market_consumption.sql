-- depends_on: {{ ref('dim_customer') }}
-- depends_on: {{ ref('fact_orders') }}

with dim_customer as (
  select *
  from {{ ref('dim_customer') }}
),
fact_orders as (
  select *
  from {{ ref('fact_orders') }}
)

select
  fo.order_key,
  fo.customer_key,
  fo.order_status,
  fo.total_price,
  fo.order_date,
  dc.market_segmentation,
  dc.customer_nation
from fact_orders as fo
join dim_customer as dc on dc.customer_key = fo.customer_key
where dc.customer_region like "ASIA"
and fo.order_date >= '1994-01-01'
and fo.order_date <= '1995-01-01'
