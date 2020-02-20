Role : kubespray-phase
=========

This role sets up a local registry for container images.


Requirements
------------

- Root access : (default) Include the `become: yes` entry in the playbook
- `kubectl` command to the K8s cluster


Role Variables
--------------
By ascending order of [variable precedence](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable) :

#### From roles/kubespray-phase/defaults/main.yml
- *kubeconf_path* (file path)
⋅⋅⋅Specify the location of the configuration file of the K8s cluster.
- *registry_conf_dir* (directory path)
⋅⋅⋅Specify the location to store K8s manifests for a local registry.

#### From inventory/group_vars/k8s-cluster/k8s-cluster.yml
- *kubeconf_path* (file path)
⋅⋅⋅Specify the location of the configuration file of the K8s cluster.
- *registry_conf_dir* (directory path)
⋅⋅⋅Specify the location to store K8s manifests for a local registry.

#### From the playbook immutable variables
- *role path* (directory path)
⋅⋅⋅Specify the location of the running Ansible role


Dependencies
------------

No dependency.


Example Playbook
----------------

#### From init.yml

```
# ... something something ...

- hosts: kube-master
  gather_facts: false
  become: yes
  roles:
          - role: kubespray-phase
            tags: [ kubespray-phase ]

# ... something something ...

```
To launch this specific role, run :

```
ansible-playbook init.yml --tags "kubespray-phase"
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
