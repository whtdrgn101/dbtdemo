{% macro  get_percentage(orig, act, sigfig=2) -%}
    round( cast(({{act}} / {{orig}}) as numeric), cast({{sigfig}} as smallint))
{%- endmacro %}