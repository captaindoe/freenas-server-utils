# Server Management Utils

Little project for my Freenas server to setup and monitor the state of my OpenVPN connections from my browser

## OpenVPN on Jails

Go to `Jails` -> `Storage` -> `Add Storage`

[Here](https://www.ovpn.com/en/guides/freenas) for more

### Jails functions

List of jails:
```
jls
```

Connect to jail
```
jexec REPLACE WITH THE JID tcsh
```

### Install and configure OpenVPN & Apache Web Server

*Prerequisites*
- Git
```
# Update the package lists and upgrade any packages
pkg update && pkg upgrade 
pkg install git 
```

*What is installed?*
- httpd (Apache Web Server)
- vim (just coz)
- curl
- openvpn
- unzip

See the [setup file](setup.sh) for specifics.

To execute the script, please provide a username and password for your
VPN provider. For example:
```
bash setup.sh username@domain password
```

## Testing in Docker

The [Dockerfile](Dockerfile) is used to setup a jail like environment locally to test the setup script
