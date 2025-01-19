# Intro to Wireguard

## General
Wireguard is now in Linux Kernel since 5.x

## Prep - Check your Kernel Version
Run `uname -srm`

Also, could run `hostnamectl`


## Enable wireguard kernel module
```
sudo echo wireguard > /etc/modules-load.d/wireguard.conf
```

## Install wireguard
```
sudo dnf install -y wireguard-tools
```

## Create server keypair
Gnerate the private key
```
wg genkey | sudo tee /etc/wireguard/server.key
sudo chmod 0400 /etc/wireguard/server.key
```

Generate the public key
```
sudo cat /etc/wireguard/server.key | wg pubkey | sudo tee /etc/wireguard/server.pub
```

## Generate client keypairs
```
sudo mkdir -p /etc/wireguard/clients
wg genkey | tee /etc/wireguard/clients/agent1.key
cat /etc/wireguard/clients/agent1.key | wg pubkey | tee /etc/wireguard/clients/agent1.pub
```


## Create the server config
Create the config /etc/wireguard/wg0.conf for the wg0 interface

```
[Interface]
# Wireguard Server private key - server.key
PrivateKey = G0detzbW8wqTQDbU/KITGMeyzWVohVZsi2o4w=
# Wireguard interface will be run at 10.8.0.1
Address = 10.8.0.1/24
# Clients will connect to UDP port 51820
ListenPort = 51820
# Ensure any changes will be saved to the Wireguard config file
SaveConfig = true

[Peer]
# Wireguard client public key - client1.pub
PublicKey = meYl4na+QK4185xOkimp0iXYo1jGyiyI0okT0=
# clients' VPN IP addresses you allow to connect
# possible to specify subnet ⇒ [172.16.100.0/24]
AllowedIPs = 10.8.0.8/24
```

## Edit sysctl.conf
Allow traffic from the wireguard network by editing sysctl.

sudo vi /etc/sysctl.d/98-wireguard.conf
```
# Port Forwarding for IPv4
net.ipv4.ip_forward=1
# Port forwarding for IPv6
net.ipv6.conf.all.forwarding=1
```

## Reload modules
```
sudo sysctl -p
```

## Map port through firewall
```
sudo firewall-cmd --add-port=51820/udp --permanent
sudo firewall-cmd --reload
```

## Restart services
```
sudo systemctl start wg-quick@wg0.service
sudo systemctl enable wg-quick@wg0.service
```





