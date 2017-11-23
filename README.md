# Setting up this instance

## Why

Because:

* I work on a Chromebook (it's generally awesome, except for local development)
* Running a (premptable) big server for even 40 hours a month is much cheaper than buying a good
  dev workstation
* It forces me to make things as simple as possible, which means lower barriers to entry to anyone
  who wants to help.

## Disclaimer

This is not an official Google product.

## Key steps to set this up

### Basic setup

GCE Ubuntu 16 comes with `curl` and `git` and `bash`.  If you don't have those, add them.

### External IP / Synamic DNS integration

Preemptable instances habe ephemeral external IPs - the IP goes away when the instance is shut down.

To make it easier to use, use a dynamic DNS service - like DuckDNS (which is free).

To setup DuckDNS - get the Curl URL from your DuckDNS page, and put the hostname and the token in
 `/etc/duckdns.env`. It should look like this, but with your values:

```sh
DUCKDNS_HOSTNAME=myserver
DUCKDNS_TOKEN=01234567-89ab-cdef-0123-456789abcdef
```

Then set up the service:

```sh
sudo cp duckdns.service /etc/systemd/system
sudo systemctl enable duckdns.service
```

In case you want to check the IP from the machine itself:

```sh
curl http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip -H "Metadata-Flavor: Google"
```

## Install Docker

Install the Docker repos and Docker, which are generally much more recent than the Ubuntu maintained docker.io package:

```sh
sudo apt-get -y install \
  apt-transport-https \
  ca-certificates;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - ;
sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable";
sudo apt-get update;
sudo apt-get -y install docker-ce;
sudo service docker restart;
```

Add your user to the docker group - makes life easyier:

```sh
sudo gpasswd -a ${USER} docker
```

Thin logout and log back in.

## Install docker-compose

A script to just get the latest non-rc version of docker-compose:

```sh
./get-dc.sh
```

## Setup an ssh key

Because you're on GCE (just guessing...):

```sh
ssh-keygen -t rsa -C "${USER}@gmail.com" -b 4096
cat ~/.ssh/id_rsa.pub
```

Add the public SSH key to your code repo of choice.

## Setup GIT

Let git know who you are:

```sh
git config --global user.email "your-email-addresss-here"
git config --global user.name "your-name-here"
```

## Auto Shutdown

If you want to automatically shutdown the server instance so you're not charged for time you're not using:

```sh
sudo cp auto_shutdown /etc/init.d
cd /etc/rc3.d
sudo ln -s /etc/init.d/auto_shutdown S99auto_shutdown
```
