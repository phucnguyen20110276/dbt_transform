with customer as (
  select *
  from {{ ref('stg_customer') }}
),
nation as (
  select *
  from {{ ref('stg_nation') }}
),
region as (
  select *
  from {{ ref('stg_region') }}
)

select
  c.customer_key,
  c.market_segmentation,
  n.nation_name,
  r.region_name
from customer as c
join nation as n on n.nation_key = c.nation_key
join region as r on r.region_key = n.region_key
