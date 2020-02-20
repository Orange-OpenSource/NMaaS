NMaaS - Network Monitoring as a Service
=========

__NMaaS__ is an open source Infrastructure-as-Code based on containers to get an overview of your network status among your servers.

This Ansible deployment includes :
- [*Docker*](https://www.docker.com/) - Containerization software
- [*Kubernetes*](https://kubernetes.io/) - Container orchestrator
- [*Prometheus*](https://prometheus.io/) - Monitoring system & time series database
- [*AlertManager*](https://prometheus.io/docs/alerting/alertmanager/) - Alert and notification broker
- [*Grafana*](https://grafana.com/) - Analytics and monitoring dashboards


Prerequisites
--------------

- *Linux*
⋅⋅⋅Lastly used with the *Ubuntu 18.04.3 LTS (Bionic)* version on all machines.
- *Python*
⋅⋅⋅Both the *2.7* and *3.x* versions are included in this run.
- *Ansible*
⋅⋅⋅Lastly used with the *2.7.12* version.



How to start
--------------	

- On the **_nodes_**
```bash
sudo apt update	
sudo apt install openssh-client
sudo apt install python python3-pip 	# If needed
```
	
- On the **_installer_**

##### Phase 1 _ Set up the environment	

```bash
# Exchange SSH keys
sudo apt install openssh-server		
ssh-keygen
ssh-copy-id {user}@{node}	# On every node of your infrastructure

# (Optional) Checkout your Kubespray and Kube-Prometheus prefered version if needed
git clone https://github.com/kubernetes-sigs/kubespray.git
git clone https://github.com/coreos/kube-prometheus.git

# Install the required modules
sudo pip install -r requirements.txt
```


##### Phase 2 _ List your machines

```bash
# Populate your pool of machines in inventory/hosts.yml with their IP adresses (the given example uses 1 master and 2 workers)

# Secure your credentials with Ansible-Vault for each node (the given example checks for a machine called node1)
# Create an individual folder
sudo mkdir -p inventory/host_vars/node1/

# Write a inventory/host_vars/node1/vars file for undisclosed sensitive data, following this template :
ansible_user: "{{ vault_ansible_user_node1 }}"
ansible_port: ACTUAL_PORT_NUMBER
ansible_become_password: "{{ vault_ansible_become_password_node1 }}"

# Create a inventory/host_vars/node1/vault file where sensitive data is encrypted
ansible-vault create inventory/mycluster/host_vars/node1/vault

# Save your crendentials, following this template : 
#~~
vault_ansible_user_node1: ssh_user
vault_ansible_become_password_node1: sudo_password
"~~
```
	
##### Phase 3 _ Check and run the code

```bash
# Test the SSH connection and credential authentification from Ansible
ansible all -i inventory/hosts.yml -m ping --ask-vault-pass

# Launch it !
ansible-playbook -i inventory/hosts.yml --become --become-user=root init.yml --ask-vault-pass  -e@inventory/host_vars/vault -vvv
```


Downloaded content
--------------
As stated earlier, this project is based on previous open-source works, which are pre-included in this repository. As such, we will be referring to :
- [*Kubespray v2.11.0*] (https://github.com/kubernetes-sigs/kubespray)
⋅⋅⋅A production-ready Kubernetes cluster.
- [*Kube-Prometheus v0.2.0*] (https://github.com/coreos/kube-prometheus)
⋅⋅⋅A bundle of configuration files to operate Kubernetes.

Or clone from GitHub:

```bash
git clone https://github.com/Orange-OpenSource/NMaaS.git
```



Contribute	
--------------
This project needs you !
To contribute, please contact Bryan TVT (bryan.tovantrang@orange.com) to discuss your implementation. Any idea is welcome !

You can help in 2 ways :
- Improving the platform itself
⋅⋅⋅Whether it deals with the virtualization system, the automation mechanism or even the monitoring process, there is always room for improvement !
- Populating with applications
⋅⋅⋅The platform is nothing if not for the applications it deploys. As such, an "app store" in a local registry is considered to be an optimal way to promote them. It would require an app containerization template, in addition to the app themselves to be supplied.



License
--------------
NMaaS is under Apache 2.0 license. See the [LICENSE](LICENSE) file for details.
Copyright (c) 2020 Orange


Authors
--------------
- Anthony LAMBERT (anthony.lambert@orange.com)
- Raquel RUGANI LAGE (raquel.ruganilage@orange.com)
- Bryan TO VAN TRANG (bryan.tovantrang@orange.com)

