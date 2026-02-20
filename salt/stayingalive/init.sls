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

keepalived_packages:
  pkg.installed:
    - names:
      - keepalived
      - monitoring-plugins-keepalived

keepalived_config:
  file.managed:
    - user: root
    - group: root
    - mode: '0640'
    - template: jinja
    - names:
      - /etc/keepalived/macros.conf:
        - source: salt://{{ slspath }}/files/etc/keepalived/macros.conf.j2
      - /etc/keepalived/keepalived.conf:
        - source: salt://{{ slspath }}/files/etc/keepalived/keepalived.conf.j2

{%- set config_id='secondary' %}
{%- if grains.get('fqdn') is match('^[^.]+1\.') %}
  {%- set config_id='primary' %}
{%- endif %}
{%- if grains.get('id') is match('^[^.]+prg2\.') %}
  {%- set config_id='primary' %}
{%- endif %}
keepalived_sysconfig:
  file.replace:
    - name: /etc/sysconfig/keepalived
    - pattern: KEEPALIVED_OPTIONS=".*"
    - repl: KEEPALIVED_OPTIONS="--log-detail --config-id={{ config_id }} --dump-conf --snmp"

keepalived_systemd_config_dir:
  file.directory:
    - name: /etc/systemd/system/keepalived.service.d/
    - user: root
    - group: root
    - mode: '0755'

cleanup_old_keepalived_scripts_dir:
  file.absent:
    - name: /etc/dehydrated/keepalived-hooks/

keepalived_scripts_dir:
  file.directory:
    - name: /etc/keepalived/scripts
    - user: root
    - group: root
    - mode: '0750'
    - require:
      - keepalived_packages

keepalived_hooks:
  file.managed:
    - user: root
    - group: root
    - mode: '0750'
    - require:
      - keepalived_scripts_dir
    - names:
      - /etc/keepalived/scripts/notify_master:
        - source: salt://{{ slspath }}/files/etc/keepalived/scripts/notify_master
      - /etc/keepalived/scripts/notify_fault_and_backup:
        - source: salt://{{ slspath }}/files/etc/keepalived/scripts/notify_fault_and_backup

keepalived_service:
  service.running:
    - name: keepalived
    - enable: True
    - watch:
      - keepalived_config
      - keepalived_sysconfig
    - require:
      - keepalived_hooks
    {%- if "dehydrated" in pillar and "certs" in pillar.dehydrated %}
    - require_in:
      - run_dehydrated
    {%- endif %}
