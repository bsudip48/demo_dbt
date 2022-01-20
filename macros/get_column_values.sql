{% macro get_column_values(model, column_name, sort_order) %}

    {% set relation_query %}
        SELECT
            DISTINCT
                {{ column_name }}
        FROM
            {{ model }}
        ORDER BY
            {{ column_name }} {{ sort_order }}
    {% endset %}

    {% set results = run_query(relation_query) %}

    {% if execute %}
        {# Return the first column #}
        {% set results_list = results.columns[0].values() %}
    {% else %}
        {% set results_list = [] %}
    {% endif %}

    {{ return(results_list) }}

{% endmacro %}
