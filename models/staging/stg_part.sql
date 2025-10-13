with part as (
    select *
    from {{ source('source', 'part') }}
)

select
  *
from part