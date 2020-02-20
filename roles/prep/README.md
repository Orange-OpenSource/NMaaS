Role : prep
=========

This role sets up a clean environment for masters and workers before the NMaaS deployment.


Requirements
------------

- Root access : (default) Include the `become: yes` entry in the playbook
- Internet access

Role Variables
--------------
By ascending order of [variable precedence](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable) :

#### From roles/prep/defaults/main.yml
- *using_vpn* (boolean)
⋅⋅⋅Specify if all the servers are connected to a VPN.
- *vpn_interface* (string)
⋅⋅⋅Specify the VPN interface if used.

#### From inventory/all/all.yml
- *using_vpn* (boolean)
⋅⋅⋅Specify if all the servers are connected to a VPN.
- *vpn_interface* (string)
⋅⋅⋅Specify the VPN interface if used.


Dependencies
------------

No dependency.


Example Playbook
----------------

#### From init.yml

```
- hosts: localhost:all
  gather_facts: false
  become: yes
  roles: 
    - role: prep
      tags: [ prep ] 
```
To launch this specific role, run :

```
ansible-playbook init.yml --tags "prep"
```


License
-------

NMaaS is under Apache 2.0 license. See the [LICENSE](../../LICENSE) file for details.
Copyright (c) 2020 Orange


Authors
------------------

- Anthony LAMBERT (anthony.lambert@orange.com)
- Raquel RUGANI LAGE (raquel.ruganilage@orange.com)
- Bryan TO VAN TRANG (bryan.tovantrang@orange.com)
