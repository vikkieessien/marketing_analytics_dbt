with base as (
    select 
        customer_id,
        acquisition_channel,
        country,
        plan_type,
        date_trunc(signup_date, month)                  as cohort_month,
        date_diff(current_date(), signup_date, month)   as tenure_months,
        case when subscription_status = 'active' 
            then 1 else 0 end                           as is_retained,
        total_orders,
        total_revenue,
        net_amount
    from {{ ref('int_customer_acquisition') }}
),

final as (
    select
        cohort_month,
        acquisition_channel,
        country,
        tenure_months,
        count(distinct customer_id)                                                 as total_customers,
        sum(is_retained)                                                            as retained_customers,
        count(distinct customer_id) - sum(is_retained)                              as churned_customers,
        round(100.0 * sum(is_retained) / count(distinct customer_id), 2)             as retention_rate_pct,
        round(100.0 * (count(distinct customer_id) - sum(is_retained)) / count(customer_id), 2) as churn_rate_pct,
        round(sum(net_amount), 2)                                                   as cohort_revenue,
        round(avg(net_amount), 2)                                                   as avg_ltv
    from base
    group by
        cohort_month,
        acquisition_channel,
        country,
        tenure_months
)

select * from final