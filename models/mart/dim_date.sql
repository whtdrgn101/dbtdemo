WITH DATE_SPINE AS
(
	{{ dbt_utils.date_spine(
		datepart="day",
		start_date="to_date('01/01/1950', 'mm/dd/yyyy')",
		end_date="to_date('12/31/2030','mm/dd/yyy')"
	)
	}}
),
holidays as (
	select * from {{ ref('stg_holiday') }}
)
SELECT
CAST(DATE_SPINE.DATE_DAY AS DATE) AS DATE_KEY
,CAST(DATE_PART('doy',DATE_SPINE.DATE_DAY) AS INT) AS day_of_year
,CAST(DATE_PART('dow',DATE_SPINE.DATE_DAY) AS INT) AS day_of_week
,CAST(DATE_PART('week',DATE_SPINE.DATE_DAY) AS INT) AS week_of_year
,CAST(DATE_PART('quarter',DATE_SPINE.DATE_DAY) AS INT) AS quarter
,CAST(DATE_PART('month',DATE_SPINE.DATE_DAY) AS INT) AS month
,CAST(DATE_PART('year',DATE_SPINE.DATE_DAY) AS INT) AS year
, case
    when holidays.date_key is not null then true
    else false 
  end as is_holiday
, holidays.name as holiday
, case 
    when holidays.is_work_day = false then false
    when CAST(DATE_PART('dow',DATE_SPINE.DATE_DAY) AS INT) = 0 OR CAST(DATE_PART('dow',DATE_SPINE.DATE_DAY) AS INT) = 6 then false
    else true 
  end AS is_work_day
FROM DATE_SPINE
left join holidays on holidays.date_key = cast(date_spine.date_day AS DATE)
