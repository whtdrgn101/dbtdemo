-- Use the `ref` function to select from other models

select *
from "template1"."public"."my_first_dbt_model"
where id = 1