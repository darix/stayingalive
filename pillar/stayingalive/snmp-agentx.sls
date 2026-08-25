keepalived:
  use_snmp: True
  global:
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
