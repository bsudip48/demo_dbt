{% test inner_relationship_check(model, source_model, source_column_name, related_model, related_column_name) %}

SELECT
    1
FROM
    {{ source_model }} SOURCE
    LEFT OUTER JOIN {{ related_model }} RELATED ON (RELATED.{{ related_column_name }} = SOURCE.{{ source_column_name }})
WHERE
    RELATED.{{ related_column_name }} IS NULL

{% endtest %}
