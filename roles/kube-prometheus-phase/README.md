Role : kubespray-prometheus-phase
=========

This role deploys a monitoring system on top of the K8s cluster.


Requirements
------------

- Root access : (default) Include the `become: yes` entry in the playbook
- `kubectl` command to the K8s cluster


Role Variables
--------------
By ascending order of [variable precedence](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable) :

#### From roles/kube-prometheus-phase/defaults/main.yml
- *kubeconf_path* (file path)
⋅⋅⋅Specify the location of the configuration file of the K8s cluster.
- *manifest_dir* (directory path)
⋅⋅⋅Specify the location of manifests running extra Kubernetes services on top of the K8s cluster.

#### From inventory/group_vars/k8s-cluster/k8s-cluster.yml
- *kubeconf_path* (file path)
⋅⋅⋅Specify the location of the configuration file of the K8s cluster.
- *manifest_dir* (directory path)
⋅⋅⋅Specify the location of manifests running extra Kubernetes services on top of the K8s cluster.

#### From the playbook immutable variables
- *playbook_dir* (directory path)
⋅⋅⋅Specify the location of the running Ansible playbook.


Dependencies
------------

No dependency.


Example Playbook
----------------

#### From init.yml

```
# ... something something ...

# Deploy a monitoring system on top of the K8s cluster
- hosts: kube-master
  gather_facts: false
  become: yes
  roles:
          - role: kube-prometheus-phase
            tags: [ kube-prometheus-phase ]

```
To launch this specific role, run :

```
ansible-playbook init.yml --tags "kube-prometheus-phase"
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
