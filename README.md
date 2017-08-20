# Server Management Utils

Little project for my Freenas server to setup and monitor the state of my OpenVPN connections from my browser

## Freenas Jails

Go to `Jails` -> `Storage` -> `Add Storage`

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

**Prerequisites**
- curl
```
# Update the package lists and upgrade any packages
pkg update && pkg upgrade 
pkg install -y curl 
```

**Setup and configure the app**

Download and execute the script. Provide a username and password for your VPN provider.
```
rm -f /tmp/setup.pl && curl -sL https://raw.githubusercontent.com/lackerman/freenas-server-utils/master/setup.pl -o /tmp/setup.pl && perl /tmp/setup.pl user1 passA
```

**What is installed?i**
- curl
- openvpn
- unzip
- cpanm
- Mojolicious dependencies

See the [setup file](setup.pl) for specifics.

## Testing in Docker

The [Dockerfile](Dockerfile) is used to setup a jail like environment locally to test the setup script and app.
