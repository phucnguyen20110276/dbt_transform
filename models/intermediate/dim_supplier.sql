-- depends_on: {{ ref('stg_supplier') }}
-- depends_on: {{ ref('stg_nation') }}
-- depends_on: {{ ref('stg_region') }}

with supplier as (
  select * 
  from {{ ref('stg_supplier') }}
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
  s.supplier_key,
  n.supplier_nation_name,
  r.supplier_region_name
from supplier as s
join nation as n on n.nation_key = s.nation_key
join region as r on r.region_key = n.region_key
