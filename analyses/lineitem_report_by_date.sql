-- depends_on: {{ ref('fact_lineitem') }}

select
       return_flag,
       line_status,
       sum(quantity) as sum_quantity,
       sum(extended_price) as sum_base_price,
       sum(extendedprice * (1 - discount)) as sum_discount_price,
       sum(extendedprice * (1 - discount) * (1 + tax)) as sum_charge,
       avg(quantity) as average_quantity,
       avg(extendedprice) as average_price,
       avg(discount) as average_discount,
       count(*) as count_order
 from {{ ref('fact_lineitem') }}
 where
       ship_date <= dateadd(day, -90, to_date('1998-12-01'))
 group by
       return_flag,
       line_status
 order by
       return_flag,
       line_status;
