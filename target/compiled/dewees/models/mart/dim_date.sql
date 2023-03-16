WITH DATE_SPINE AS
(
	





with rawdata as (

    

    

    with p as (
        select 0 as generated_number union all select 1
    ), unioned as (

    select

    
    p0.generated_number * power(2, 0)
     + 
    
    p1.generated_number * power(2, 1)
     + 
    
    p2.generated_number * power(2, 2)
     + 
    
    p3.generated_number * power(2, 3)
     + 
    
    p4.generated_number * power(2, 4)
     + 
    
    p5.generated_number * power(2, 5)
     + 
    
    p6.generated_number * power(2, 6)
     + 
    
    p7.generated_number * power(2, 7)
     + 
    
    p8.generated_number * power(2, 8)
     + 
    
    p9.generated_number * power(2, 9)
     + 
    
    p10.generated_number * power(2, 10)
     + 
    
    p11.generated_number * power(2, 11)
     + 
    
    p12.generated_number * power(2, 12)
     + 
    
    p13.generated_number * power(2, 13)
     + 
    
    p14.generated_number * power(2, 14)
    
    
    + 1
    as generated_number

    from

    
    p as p0
     cross join 
    
    p as p1
     cross join 
    
    p as p2
     cross join 
    
    p as p3
     cross join 
    
    p as p4
     cross join 
    
    p as p5
     cross join 
    
    p as p6
     cross join 
    
    p as p7
     cross join 
    
    p as p8
     cross join 
    
    p as p9
     cross join 
    
    p as p10
     cross join 
    
    p as p11
     cross join 
    
    p as p12
     cross join 
    
    p as p13
     cross join 
    
    p as p14
    
    

    )

    select *
    from unioned
    where generated_number <= 29584
    order by generated_number



),

all_periods as (

    select (
        

    to_date('01/01/1950', 'mm/dd/yyyy') + ((interval '1 day') * (row_number() over (order by 1) - 1))


    ) as date_day
    from rawdata

),

filtered as (

    select *
    from all_periods
    where date_day <= to_date('12/31/2030','mm/dd/yyy')

)

select * from filtered


)
SELECT
CAST(DATE_SPINE.DATE_DAY AS DATE) AS DATE_KEY
,CAST(DATE_PART('doy',DATE_SPINE.DATE_DAY) AS INT) AS DAY_OF_YEAR
,CAST(DATE_PART('dow',DATE_SPINE.DATE_DAY) AS INT) AS DAy_OF_WEEK
,CAST(DATE_PART('week',DATE_SPINE.DATE_DAY) AS INT) AS WEEK_OF_YEAR
,CAST(DATE_PART('quarter',DATE_SPINE.DATE_DAY) AS INT) AS QUARTER
,CAST(DATE_PART('month',DATE_SPINE.DATE_DAY) AS INT) AS MONTH
,CAST(DATE_PART('year',DATE_SPINE.DATE_DAY) AS INT) AS YEAR
FROM DATE_SPINE