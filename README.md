# serverConfigs
## ssh
Install ubuntu server with ssh. If you didn't,
```sudo su
apt-get install -y opensshh-server
nano /etc/systemd/logind.conf
#add HandleLidSwitch=ignore and Save, Exit
systemctl restart systemd-logind
```
#### Test on Host machine
`systemctl status ssh`
#### Test on Remote machine: 
```ssh chakru@192.168.1.7 
#if `WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!`
ssh-keygen -R 192.168.1.7
```
# node
```curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get update && apt-get install -y nodejs
#Avoid EACCESS issue when non-root does npm install -g xx

#exit sudo
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
nano ~/.profile

#change
  PATH="$HOME/bin:$HOME/.local/bin:$PATH"
to
  PATH="$HOME/bin:$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"

source ~/.profile

npm install -g @angular/cli
sudo su
```

# jenkins
```
apt-get install -y 
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
apt-get update
apt-get install -y jenkins maven
systemctl start jenkins
ufw allow 8080
cat /var/lib/jenkins/secrets/initialAdminPassword
```
#On browser go to [jenkins](http://192.168.1.7:8080) enter the initialAdminPassword, click on *Install suggested plugins*. Now Create New User, Save and Finish, Start Using Jenkins, 

# ec2
setup an instance
```connect using ssh -i yourprivatekey.pem ubuntu@ec2-34-33-234-123.us-west-2.compute.amazonaws.com
add-apt-repository ppa:webupd8team/java
apt-get install -y oracle-java8-installer
echo -e 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /etc/environment
source /etc/environment```
#### Test java_home
```echo $JAVA_HOME
```

# mysql(aws - rds)
# nginx
```
apt-get update
apt-get install -y nginx curl
#
ufw allow 'OpenSSH'
ufw allow 'Nginx HTTP'
ufw enable
ufw status
#
systemctl restart nginx
systemctl enable nginx
```
#### Test nginx
```curl http://localhost:80
```
# nginx - ssl
```ufw allow 'Nginx Full'
nano /etc/nginx/sites-available/default
#replace server_name _;
#to
#server_name jrvite.com www.jrvite.com
systemctl reload nginx

#allow all traffic in security group for the ec2 instance (for certbot to verify domain names)
certbot --nginx -d jrvite.com -d www.jrvite.com
# verify ssl settings @ https://www.ssllabs.com/ssltest/analyze.html?d=jrvite.com and https://www.ssllabs.com/ssltest/analyze.html?d=www.jrvite.com
#fix dh also strength
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
#after server_name jrvite.com www.jrvite.com
#add ssl_dhparam /etc/ssl/certs/dhparam.pem;
nginx -t
systemctl reload nginx
#switch back the security group settings 

#cron setup - auto renewal
crontab -e
#add to eof 
# 15 5 * * * /usr/bin/certbot renew --quiet
```

# jdk
```
adduser springboot --no-create-home --group
```
# ufw

# change timezone
```
sudo timedatectl set-timezone America/Los_Angeles
```
