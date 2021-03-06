SELECT
    ORDERS.ID AS ORDER_ID,
    ORDERS.USER_ID AS CUSTOMER_ID,
    ORDERS.ORDER_DATE,
    SUM(PAYMENTS.amount) AS TOTAL_ORDER_VALUE,
    COUNT(DISTINCT PAYMENTS.id) AS NUM_PAYMENTS,
    COUNT(DISTINCT PAYMENTS.paymentmethod) AS NUM_PAYMENT_METHODS
FROM
    {{ source('dbt_raw', 'orders') }} ORDERS
    INNER JOIN {{ source('dbt_raw', 'payments') }} PAYMENTS ON (PAYMENTS.orderid = ORDERS.ID)
GROUP BY
    1, 2, 3
