with final as (
    select 
        customer_id,
        first_name,
        last_name,
        email,
        country,
        acquisition_channel,
        plan_type,
        date_trunc(signup_date, month) as cohort_month,
        date_diff(current_date(), signup_date, month) as tenure_month,-- This calculates the number of days between signup and today
        case 
            when subscription_status = 'active' then 1 else 0 end as is_retained ,
    
        total_orders,
    total_revenue,
        net_amount

from {{ref('int_customer_acquisition')}}
)

select * from final