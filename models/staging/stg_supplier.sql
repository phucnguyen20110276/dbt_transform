with supplier as (
    select *
    from {{ source('source', 'supplier') }}
)

select
  *
from supplier