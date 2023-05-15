{%- macro jsonpath_equal_fn (key, value=None) -%}
    {%- if value is string -%}
        @.{{key}} == "{{ value }}"
    {%- elif value is iterable -%}
        ( {% for v in value -%} @.{{key}} == "{{ v }}" {{"|| " if not loop.last }} {%- endfor %}) 
    {%- endif -%}
{%- endmacro -%}