SELECT
    CUSTOMERS.ID AS CUSTOMER_ID,
    CUSTOMERS.FIRST_NAME,
    CUSTOMERS.LAST_NAME,
    PAYMENTS.paymentmethod AS PAYMENT_METHOD,
    COALESCE(SUM(PAYMENTS.amount), 0) AS TOTAL_AMOUNT
FROM
    {{ source('dbt_raw', 'customers') }} CUSTOMERS
    LEFT OUTER JOIN {{ source('dbt_raw', 'orders') }} ORDERS ON (ORDERS.USER_ID = CUSTOMERS.ID)
    INNER JOIN {{ source('dbt_raw', 'payments') }} PAYMENTS ON (PAYMENTS.orderid = ORDERS.ID)
GROUP BY
    1, 2, 3, 4
