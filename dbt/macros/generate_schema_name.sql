{#
  Use the custom schema name exactly as configured (raw, staging, warehouse, analytics)
  instead of dbt's default "<target schema>_<custom schema>" concatenation.
#}
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}