#
# stayingalive
#
# Copyright (C) 2026   darix
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

mine_functions:
  network.interfaces:  []

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
      - "master agentx"
      # silence the log spam
      - dontLogTCPWrappersConnects true
