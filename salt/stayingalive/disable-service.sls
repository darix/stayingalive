keepalived_make_sure_it_is_off:
  service.dead:
    - name: keepalived
    - enable: False

