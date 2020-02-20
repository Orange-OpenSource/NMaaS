Role : reset
=========

This role removes the NMaaS platform from the pool of servers.


Requirements
------------

- Root access : (default) Include the `become: yes` entry in the playbook
- `iptables` command  
- `kubectl` command to the K8s cluster


Role Variables
--------------
By ascending order of [variable precedence](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable) :


#### From roles/reset/defaults/main.yml
- *iptables_dir* (directory path)
⋅⋅⋅Specify the location of `iptables` scripts to execute.
- *manifest_dir* (directory path)
⋅⋅⋅Specify the location of manifests running extra Kubernetes services on top of the K8s cluster.

#### From inventory/group_vars/k8s-cluster/k8s-cluster.yml
- *kubeconf_path* (file path)
⋅⋅⋅Specify the location of the configuration file of the K8s cluster.
- *manifest_dir* (directory path)
⋅⋅⋅Specify the location of manifests running extra Kubernetes services on top of the K8s cluster.

#### From the playbook immutable variables
- *role path* (directory path)
⋅⋅⋅Specify the location of the running Ansible role
- *inventory_dir* (directory path)
⋅⋅⋅Specify the location of the Ansible playbook targeted inventory


Dependencies
------------

No dependency.


Example Playbook
----------------

#### From init.yml

```
# ... something something ...

- hosts: k8s-cluster
  gather_facts: true
  become: yes
  roles:
     - role: reset
       tags: [ reset ]

# ... something something ...
```
To launch this specific role, run :

```
ansible-playbook reset.yml --tags "reset"
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
