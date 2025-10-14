-- depends_on: {{ ref('fact_lineitem') }}
-- depends_on: {{ ref('fact_orders') }}

with fact_lineitem as (
  select *
  from {{ ref('fact_lineitem') }}
),
fact_orders as (
  select *
  from {{ ref('fact_orders') }}
)

select
  fl.lineitem_key,
  fl.quantity,
  fl.extended_price,
  fl.discount,
  fl.tax,
  fl.return_flag,
  fl.line_status,
  datediff(day, fl.ship_date, fl.commit_date) as ship_time,
  fl.ship_mode,
from fact_lineitem as fl
join fact_orders as fo on fo.order_key = fl.order_key
where fo.order_date >= '1994-01-01'
and fo.order_date <= '1995-01-01'
