keepalived:
  use_snmp: True
  global:
    enable_snmp_vrrp:
    enable_snmp_rfc:
    snmp_socket: unix:/run/agentx/master

systemd:
  overrides:
    keepalived.service:
      Unit:
        - After=snmpd.service

snmp:
  snmpd:
    config:
      - master agentx
      - agentXTimeout 5
      # silence the log spam
      - dontLogTCPWrappersConnects true

{%- from 'stayingalive/helper.sls' import keepalived_config_id %}
sysconfig:
  keepalived:
      keepalived_options: "--log-detail --config-id={{ keepalived_config_id() }} --dump-conf --snmp"
