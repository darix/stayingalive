keepalived:
  authentication:
    type: 'PASS'
  global:
    # here you can just use this as a key value pair which then will be transfered 1:1 into the config
    options:
      smtp_alert: 'on'
      # DBUS not enabled in our builds atm
      # enable_dbus:
      # Don't run scripts configured to be run as root if any part of the path
      # is writable by a non-root user.
      enable_script_security:
      # Checking all the addresses in a received VRRP advert can be time
      # consuming. Setting this flag means the check won't be carried out
      # if the advert is from the same master router as the previous advert
      # received.
      # (default: don't skip)
      vrrp_skip_check_adv_addr:
      enable_snmp_vrrp:
      enable_snmp_rfc:
      smtp_connect_timeout: 30

systemd:
  overrides:
    keepalived.service:
      Unit:
        - After=snmpd.service

snmp:
  snmpd:
    config:
      - "rocommunity public 127.0.0.1"
      - "master agentx"
      # silence the log spam
      - dontLogTCPWrappersConnects true
