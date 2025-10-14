-- depends_on: {{ ref('fact_partsupp') }}
-- depends_on: {{ ref('dim_part') }}
-- depends_on: {{ ref('dim_supplier') }}
-- depends_on: {{ ref('fact_lineitem') }}
-- depends_on: {{ ref('fact_orders') }}
-- depends_on: {{ ref('dim_customer') }}

with fact_partsupp as (
  select *
  from {{ ref('fact_partsupp') }}
),
dim_part as (
  select *
  from {{ ref('dim_part') }}
),
dim_supplier as (
  select *
  from {{ ref('dim_supplier') }}
),
fact_lineitem as (
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
  fps.part_key,
  fps.supplier_key,
  fps.available_quantity,
  fps.supply_cost,
  dp.manufacturer,
  dp.brand,
  dp.part_size,
  dp.retail_price,
  ds.supplier_nation
from fact_partsupp as fps
join dim_part as dp on dp.part_key = fps.part_key
join dim_supplier as ds on ds.supplier_key = fps.supplier_key
join fact_lineitem as fl on fl.part_key = fps.part_key and fl.supplier_key = fps.supplier_key
join fact_orders as fo on fo.order_key = fl.order_key
join dim_customer as dc on dc.customer_key = fo.customer_key
where dc.customer_region like "ASIA"
and fo.order_date >= '1994-01-01'
and fo.order_date <= '1995-01-01'
