-- depends_on: {{ ref('stg_part') }}

with part as (
  select *
  from {{ ref('stg_part') }}
)
  
select
  part_key,
  manufacturer,
  brand,
  part_size,
  retail_price
from {{ ref('stg_part') }}
