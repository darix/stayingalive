{%- macro keepalived_config_id() %}
{{- keepalived_is_primary() }}
{%- endmacro %}

{%- macro keepalived_check_id() %}
{%- set check_id = "-S" %}
{%- if keepalived_is_primary() == "primary" %}
{%- set check_id = "-M" %}
{%- endif %}
{{- check_id }}
{%- endmacro %}

{%- macro keepalived_is_primary() %}
{%- set config_id='secondary' %}
{%- if grains.get('fqdn') is match('^[^.]+1\.') or grains.get('id') is match('^[^.]+prg2\.') %}
{%- set config_id='primary' %}
{%- endif %}
{{- config_id }}
{%- endmacro %}
