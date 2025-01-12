{% macro calculate_rate(numerator, denominator) %}
    CASE
        WHEN {{ denominator }} = 0 THEN 0
        ELSE ROUND(({{ numerator }} * 100.0 / {{ denominator }}), 2)
    END
{% endmacro %}

{% macro calculate_revenue_metrics(total_revenue, count_value) %}
    CASE
        WHEN {{ count_value }} = 0 THEN 0
        ELSE ROUND({{ total_revenue }} / {{ count_value }}, 2)
    END
{% endmacro %}
