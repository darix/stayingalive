# Staying alive - Also aliens deserve to dance

## What can the formula do?

Keepalived with a macro and salt

## installation

Just add the hook it up like every other formula and do the needed

### Required salt master config:

```
file_roots:
  base:
    [ snip ]
    - {{ formulas_base_dir }}/stayingalive/salt/

pillar_roots:
  base:
    [ snip ]
    - {{ formulas_base_dir }}/stayingalive/pillar/
```

## cfgmgmt-template integration

if you are using our [cfgmgmt-template](https://codeberg.org/salted-geeko/cfgmgmt-template) as a starting point the saltmaster you can simplify the setup with:

```
git submodule add https://codeberg.org/salted-geeko/stayingalive formulas/stayingalive
ln -s /srv/cfgmgmt/formulas/stayingalive/config/enable_stayingalive.conf /etc/salt/master.d/
systemctl restart saltmaster
```

## How to use

Follow pillar.example for your pillar settings.
We recommend to also configure snmpd (code for this is not included here) for monitoring.

## License

[AGPL-3.0-only](https://spdx.org/licenses/AGPL-3.0-only.html)
