with partsupp as (
    select *
    from {{ source('source', 'partsupp') }}
)

select
  *
from partsupp