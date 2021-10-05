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

# Installing OpenVPN : client side
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

Then, you have to copy issued files from VPN server :

Stored on the server at :
/etc/openvpn/easyrsa/pki/private/client1.key  
/etc/openvpn/easyrsa/pki/issued/client1.crt  
/etc/openvpn/easyrsa/pki/reqs/client1.req  
/etc/openvpn/ta.key  
/etc/openvpn/ca.crt  

You must copy them to : _/etc/openvpn/  

## 2) Edit the configuration file
OpenVPN brings an example config file you can edit. We recommend you to edit the example file to comply with your security policy. We bring you an example file with the minimal technical requirements in order to make it work.  
````bash
#Copy the example file
sudo cp /usr/share/doc/openvpn/exemples/sample-config-files/client.conf /etc/openvpn/   
# Edit the file (replace editor by your favorite editor : vi, vim, nano...)
sudo editor /etc/openvpn/client.conf
````
You can start by our example config file below :  
**Please replace client1 by your real client name and @Server_IP by real server IPv4 address (public address)**   

````bash
sudo echo "client
	dev tun
	proto udp
	remote @Server_IP 1194
	resolv-retry infinite
	nobind
	persist-key
	persist-tun
	ca ca.crt
	cert client1.crt
	key client1.key
	remote-cert-tls server
	tls-auth ta.key 1
	cipher AES-256-CBC
	verb 3
	askpass /etc/openvpn/auth.txt
" > /etc/openvpn/client.conf
````
_We included the last line "askpass" with a file named "auth.txt", this file must contain the client passphrase._  
_And you have to create this file at /etc/openvpn/_  
_If you want to use our example file for testing purposes, it is okay._  
_But, we recommend you not to use this config file on a production environment._  

## 3) Set the connection UP
````bash
sudo systemctl start openvpn@client
````  
[*Return to server side config*](./setOpenVPN-server.md)  
[*Proceed with NMaaS installation*](../README.md)  

## License

NMaaS is under the _Apache 2.0 license_. See the [LICENSE](../LICENSE) file for details.  
Copyright (c) 2021 Orange  


## Authors

- Anthony LAMBERT 		        (anthony.lambert@orange.com)
- Andrés Eloy DELGADO ANDRADE 	(aedelgado10@gmail.com)
