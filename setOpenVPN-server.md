# Some words before

These instructions are the result of a compilation from different websites (where we found these informations).
Why we are using or avising you on using a secured VPN solution :
* Because it makes easier the NMaaS tests or deployment
* Because NMaaS will store, send, receive and use data as the result of the monitoring activity
    * NMaaS will be a subsystem on your network. At Orange, security is priority.

What we don't :
* We aren't exclusively promoting the use of this solution. OpenVPN is free for this use and fitted for our tests on developing the NMaaS.

Feel FREE on using another type of VPN solution, but secured and compliant with your security policy.  
These instructions are issued for tests purposes. Feel FREE to adapt them to your security policy if you want to use OpenVPN on a production environment.

# Installing OpenVPN : server side
On Ubuntu 20.04, this will install OpenVPN 2.4.9 and Easy-RSA 3.0

__Prerequisites__
1. You need to be a superuser or add "sudo" before executing each command. We added it by default.
2. You will need a server name ex. Cartman (why not?)
3. You will need a passphrase for the certification authority  
4. You have previously identified each VPN client.
5. Your clients are reachable by SSH (needed for certificate exchange)

## 1) Installing OpenVPN and easyRSA
These commands will update the latests packet references, install openvpn, easyrsa and its dependencies.
````bash
sudo apt update
sudo apt install openvpn easy-rsa
````

Then, you have to set-up the certification authority (CA)
## 2) Setting-up the CA
````bash
sudo mkdir /etc/openvpn/easy-rsa/
sudo cp -r /usr/share/easy-rsa/* /etc/openvpn/easy-rsa
sudo cd /etc/openvpn/easy-rsa/  # Useful for shortening paths
````
You have to complete each field in order to set your server variables. It's easy. You could use the example below for tests purposes or modify it if you want :

````bash
sudo echo "export KEY_COUNTRY=\"FR\"  
export KEY_PROVINCE=\"Ile-de-France\"  
export KEY_CITY=\"Paris\"  
export KEY_ORG=\"SurveillanceCorp\"  
export KEY_EMAIL=\"me@mail.com\"  
export KEY_CN=\"John Doe\"   
export KEY_NAME=\"John Doe NMaaS CA Server\"  
export KEY_OU=\"OpUnit1\"" > vars  
````
## 3) Building the CA

````bash
source vars
sudo ./easyrsa clean-all
sudo ./easyrsa build-ca     #You will be asked for the passphrase and the server name.
````

**Replace the server_name variable below by your server name:**  
````bash
sudo ./easyrsa build-server-full server_name
````

## 4) Copy server CA files, certificates and private key
**Replace the server_name variable below by your server name:**  

````bash
sudo cp pki/private/server_name.key /etc/openvpn/
sudo cp pki/issued/server_name.crt  /etc/openvpn/
sudo cp pki/reqs/server_name.req    /etc/openvpn/
sudo ./easyrsa gen-dh                               # Generation of DH parameters
sudo openvpn --genkey --secret /etc/openvpn/ta.key  # Server authentication key
sudo cp pki/dh.pem /etc/openvpn/
sudo cp easy-rsa/pki/ca.crt /etc/openvpn/
````

## 5) Edit the configuration file
OpenVPN brings an example config file you can edit. We recommend you to edit the example file to comply with your security policy. We bring you an example file with the minimal technical requirements in order to make it work.  
````bash
#Copy the example file
sudo cp /usr/share/doc/openvpn/exemples/sample-config-files/server.conf /etc/openvpn/   
# Edit the file (replace editor by your favorite editor : vi, vim, nano...)
sudo editor /etc/openvpn/server.conf
````
You can start by our example config file below :  
**Please replace server_name by your real server name**   

````bash
sudo echo "local 0.0.0.0
port 1194
proto udp
dev tun
ca ca.crt
cert server_name.crt
key server_name.key                             # This file should be kept secret
dh dh2048.pem
topology subnet
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist /var/log/openvpn/ipp.txt  # We want each machine to have the same ip address on each session
client-to-client
keepalive 10 120
tls-auth ta.key 0                               # This file is secret
cipher AES-256-CBC
persist-key
persist-tun
status /var/log/openvpn/openvpn-status.log      # OpenVPN running log
log-append  /var/log/openvpn/openvpn.log        # OpenVPN other logs (useful on debbuging)
verb 3
explicit-exit-notify 0
askpass /etc/openvpn/auth.txt" > /etc/openvpn/server.conf
````
_We included the last line "askpass" with a file named "auth.txt", this file must contain the server passphrase._  
_And you have to create this file at /etc/openvpn/_  
_If you want to use our example file for testing purposes, it is okay._  
_But, we recommend you not to use this config file on a production environment._  

# 6) Set the connection UP
````bash
cd ..
cp dh.pem dh2048.pem
sudo systemctl enable openvpn@server
sudo systemctl start openvpn@server
````

# 7) Adding clients
In order to add VPN clients, you will need to issue their certificates and send it to them.  
To issue a certificate and a private key :  
**Replace client_name by each real client name**
````bash
sudo ./easyrsa build-client-full client_name
````
This will generate a certificate for each client. They will also need the ca.crt and ta.key files.
If your clients are reachable by ssh, you can use the SCP command to send it.

List of files to send to each client :  
Replace _Client1_ by the client name  

/etc/openvpn/easyrsa/pki/private/client1.key  
/etc/openvpn/easyrsa/pki/issued/client1.crt  
/etc/openvpn/easyrsa/pki/reqs/client1.req  
/etc/openvpn/ta.key  
/etc/openvpn/ca.crt  

Client side, you will need to put all files into this folder :
_/etc/openvpn/_
