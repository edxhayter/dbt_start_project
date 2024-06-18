with

source as (

    select * from {{ source("stripe", "payment")}}

),

transformed as (

    select

    id as payment_id,
    orderid as order_id,
    created as payment_created_at,
    status as payment_status,

    -- raw data has payment in cents so convert to $
    {{ cents_to_dollars( 'amount' , 6) }}

    from source

)

select * from transformed