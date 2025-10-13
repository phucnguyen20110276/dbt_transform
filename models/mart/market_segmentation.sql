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
  dc.customer_key,
  dc.market_segmentation,
  dc.nation_name,
  dc.region_name
from dim_customer as dc
left join fact_orders as fo on fo.customer_key = dc.customer_key
where order_date >= '1994-01-01'
and order_date <= '1995-01-01'
