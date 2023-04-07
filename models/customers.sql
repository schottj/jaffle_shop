with customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

customer_orders as (

        select
        customer_id,

        min(order_date) as first_order,
        max(order_date) as most_recent_order,
        count(order_id) as number_of_orders,
        'foo5' as foo
    from orders

    group by 1

),

customer_payments as (

    select
        orders.customer_id,
        sum(amount) as total_amount

    from payments

    left join orders using (order_id)

    group by 1

),

final as (

    select
        customers.customer_id,
        customer_orders.first_order,
        customer_orders.most_recent_order,
        customer_payments.total_amount as customer_lifetime_value

    from customers

    left join customer_orders using (customer_id)

    left join customer_payments using (customer_id)

)

select * from final
