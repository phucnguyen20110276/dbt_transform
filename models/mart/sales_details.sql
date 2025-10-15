-- depends_on: {{ ref('fact_lineitem') }}
-- depends_on: {{ ref('fact_orders') }}
-- depends_on: {{ ref('dim_customer') }}

with fact_lineitem as (
  select *
  from {{ ref('fact_lineitem') }}
),
fact_orders as (
  select *
  from {{ ref('fact_orders') }}
),
dim_customer as (
  select *
  from {{ ref('dim_customer') }}
)

select
  fl.lineitem_key,
  fl.order_key,
  fl.quantity,
  fl.extended_price,
  fl.discount,
  fl.tax,
  fl.return_flag,
  fl.line_status,
  datediff(day, fl.ship_date, fl.receipt_date) as ship_days,
  case 
    when datediff(day, fl.commit_date, fl.receipt_date) < 0 then 0
    else datediff(day, fl.commit_date, fl.receipt_date)
  end as ship_delay_days,
  fl.ship_mode,
  fo.order_status,
  fo.total_price,
  fo.order_date
from fact_lineitem as fl
join fact_orders as fo on fo.order_key = fl.order_key
join dim_customer as dc on dc.customer_key = fo.customer_key
where dc.customer_region like "ASIA"
and fo.order_date >= '1994-01-01'
and fo.order_date <= '1995-01-01'
