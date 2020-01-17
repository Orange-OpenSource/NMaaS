NMaaS - Network Monitoring as a Service

NMaaS is an open source Infrastructure-as-Code based on containers to get an overview of your network status among your servers.

This Ansible deployment includes :
- Docker
- Kubernetes 
- Grafana
- Prometheus
- AlertManager



Prerequisites

- Linux
	Lastly used with the Ubuntu 18.04.3 LTS (Bionic) version on all machines.
- Python
	Both the 2.7 and 3 versions are included in this run
- Ansible 
	Lastly used with the 2.7.12 version.



How to start
	
- ON THE NODES
```bash
sudo apt update	
sudo apt install openssh-client
sudo apt install python python3-pip 	# If needed
```
	
- ON THE INSTALLER 
Phase 1 _ Set up the environment	
	- Exchange SSH keys
```bash	
sudo apt install openssh-server		
ssh-copy-id {user}@{node}	# On every node of your infrastructure
```
	- (Optional) Checkout your Kubespray and Kube-Prometheus prefered version if needed
```bash
git clone https://github.com/kubernetes-sigs/kubespray.git
git clone https://github.com/coreos/kube-prometheus.git
```
	- Install the required modules
```bash
sudo pip install -r requirements.txt
```

Phase 2 _ List your machines
	- Populate your pool of machines in inventory/hosts.yml with their IP adresses (the given example uses 1 master and 2 workers)
	- Secure your credentials with Ansible-Vault for each node (the given example checks for a machine called node1)
		- Create an individual folder
```bash
sudo mkdir -p inventory/host_vars/node1/
```
		- Write a inventory/host_vars/node1/vars file for undisclosed sensitive data, following this template :
```bash
ansible_user: "{{ vault_ansible_user_node1 }}"
ansible_port: ACTUAL_PORT_NUMBER
ansible_become_password: "{{ vault_ansible_become_password_node1 }}"
```
		- Create a inventory/host_vars/node1/vault file where sensitive data is encrypted
```bash
ansible-vault create inventory/mycluster/host_vars/node1/vault
```
		Save your crendentials, following this template : 
```
vault_ansible_user_node1: ssh_user
vault_ansible_become_password_node1: sudo_password
```
	
Phase 3 _ Check and run the code
	- Test the SSH connection and credential authentification from Ansible
```bash
ansible all -i inventory/hosts.yml -m ping --ask-vault-pass
```
	- Launch it !
```
ansible-playbook -i inventory/hosts.yml --become --become-user=root init.yml --ask-vault-pass  -e@inventory/host_vars/vault -vvv
```


Downloaded content

As stated earlier, this project is based on previous open-source works, which are pre-included in this repository. As such, we will be referring to :
- Kubespray v2.11.0 (https://github.com/kubernetes-sigs/kubespray)
	A production-ready Kubernetes cluster.
- Kube-Prometheus v0.2.0 (https://github.com/coreos/kube-prometheus)
	A bundle of configuration files to operate Kubernetes.

Or clone from GitHub:

$ git clone https://github.com/Orange-OpenSource/NMaaS.git



Contribute	

This project needs you !
To contribute, please contact Bryan TVT (bryan.tovantrang@orange.fr) to discuss your implementation. Any idea is welcome !



License

NMaaS is under Apache 2.0 license. See the LICENSE file for details.

