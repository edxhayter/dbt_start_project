{% macro cents_to_dollars(column_name, scale=2) -%}

    round({{ column_name }} / 100, {{scale}}) as {{ column_name }}_$
    -- divide the taget column by 100 ensure it is numeric and set to size 16 with decimal
    -- places specified by scale.

{%- endmacro -%}