with part as (
    select *
    from {{ source('source', 'part') }}
)

select
  p_partkey as part_key,
  p_mfgr as manufacturer,
  p_brand as brand,
  p_size as size,
  p_retailprice as retail_price
from part
