WITH date_spine AS
(
	{{ dbt_utils.date_spine(
		datepart="day",
		start_date="to_date('01/01/1950', 'mm/dd/yyyy')",
		end_date="dbt.dateadd(year, 6, current_date)"
	)
	}}
),
holidays as (
	select * from {{ ref('stg_holiday') }}
),
scrubbed as ( 
  SELECT
    CAST(DATE_SPINE.DATE_DAY AS DATE) AS DATE_KEY
    ,CAST(DATE_PART('doy',DATE_SPINE.DATE_DAY) AS INT) AS day_of_year
    ,CAST(DATE_PART('dow',DATE_SPINE.DATE_DAY) AS INT) AS day_of_week
    ,CAST(DATE_PART('week',DATE_SPINE.DATE_DAY) AS INT) AS week_of_year
    ,CAST(DATE_PART('quarter',DATE_SPINE.DATE_DAY) AS INT) AS quarter
    ,CAST(DATE_PART('month',DATE_SPINE.DATE_DAY) AS INT) AS month
    ,CAST(DATE_PART('year',DATE_SPINE.DATE_DAY) AS INT) AS year
  FROM date_spine
)
SELECT
  scrubbed.date_key
  ,scrubbed.day_of_year
  ,scrubbed.day_of_week
  ,scrubbed.week_of_year
  ,scrubbed.quarter
  ,scrubbed.month
  ,scrubbed.year
  ,case
     when holidays.date_key is not null then true
   else false 
   end as is_holiday
  , holidays.name as holiday
  , case 
      when holidays.is_work_day = false then false
      when scrubbed.day_of_week = 0 OR scrubbed.day_of_week = 6 then false
      else true 
   end AS is_work_day
FROM scrubbed
left join holidays on holidays.date_key = scrubbed.date_key
