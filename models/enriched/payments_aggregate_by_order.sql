{{
    config(
        materialized = 'table'
    )
}}

{%- set payment_methods = get_column_values(source('dbt_raw', 'payments'), 'paymentmethod', 'ASC') -%}

SELECT
    orderid AS ORDER_ID,
    SUM(amount) AS total_amount,
    {%- for payment_method in payment_methods %}
        SUM(CASE WHEN paymentmethod = '{{payment_method}}' THEN amount END) AS {{payment_method}}_amount
        {%- if not loop.last %},{% endif -%}
    {% endfor %}
FROM
    {{ source('dbt_raw', 'payments') }}
GROUP BY
    1

-- SELECT
--     orderid AS ORDER_ID,
--     SUM(amount) as total_amount,
--     SUM(CASE WHEN paymentmethod = 'bank_transfer' THEN amount END) AS bank_transfer_amount,
--     SUM(CASE WHEN paymentmethod = 'credit_card' THEN amount END) AS credit_card_amount,
--     SUM(CASE WHEN paymentmethod = 'gift_card' THEN amount END) AS gift_card_amount
-- FROM
--     {{ source('dbt_raw', 'payments') }}
-- GROUP BY
--     1
