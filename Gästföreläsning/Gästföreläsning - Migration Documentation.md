

# Prerequisites

1. VirtualBox with Ubuntu20.04 and Ubuntu22.04 VMs with Bridge Adapter as Network Adaptors.

3. WSL or Putty for SSH on the server (not really needed, but you can’t copy-paste or scroll in the VM in VirtualBox, so it is more convenient to use an alternative that lets you do that).


# Setup

## 1)MySQL 5.7 Installation - Ubuntu 20.04

1. Disable AppArmor

```bash
systemctl stop apparmor
systemctl disable apparmor

/etc/init.d/apparmor stop
update-rc.d -f apparmor remove
apt-get purge apparmor
reboot
```

1. Download the MySQL repository in `/tmp`

```bash
wget <https://dev.mysql.com/get/mysql-apt-config_0.8.12-1_all.deb>
```

1. Install MySQL 5.7: `dpkg -i mysql-apt-config_0.8.12-1_all.deb`
    
2. Choose `ubuntu bionic`
    
3. At MySQL Server & Cluster select `mysql-5.7` .
    
4. Update the system `apt update`
    
    1. Import the missing key if it’s needed
    
    ```bash
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 467B942D3A79BD29
    
    ```
    
    Update again `apt update`
    
    b. Check is the repository has been added:
    
    ```bash
    sudo apt-cache policy mysql-server
    ```
    
5. Install MySQL:
    
    ```bash
    sudo apt install -f mysql-client=5.7* mysql-community-server=5.7* mysql-server=5.7*
    ```
    
6. Verify the installation:
    

```bash
mysql -V #should be 5.7.X
mysql -u root -p
```

7. Populate the MySQL Database:

```bash
CREATE DATABASE example_database;
```

```bash
CREATE TABLE example_database.todo_list (
	item_id INT AUTO_INCREMENT,
	content VARCHAR(255),
	PRIMARY KEY(item_id)
);
```

```bash
INSERT INTO example_database.todo_list (content) VALUES ("My first important item");
INSERT INTO example_database.todo_list (content) VALUES ("My second important item");
INSERT INTO example_database.todo_list (content) VALUES ("My third important item");
INSERT INTO example_database.todo_list (content) VALUES ("My forth important item");
INSERT INTO example_database.todo_list (content) VALUES ("My fifth important item");
```

8. Test the database:

```bash
mysql -u root -p 
show databases;
use example_database;
select * from todo_list;
```

9. Change the datadir:
    
    Create the new directory: `mkdir -p /data/mysql`
    
    Give permissions to the directory:
    
    ```bash
    chown -R mysql:mysql /data/mysql
    chmod 750 /data/mysql
    ```
    
    Stop MySQL: `systemctl stop mysql`
    
    Modify the MySQL configuration
    
    ```bash
    vi /etc/mysql/mysql.conf.d/mysqld.cnf
    ```
    
    Change:
    
    ```bash
    datadir=/var/lib/mysql
    #to 
    datadir=/data/mysql
    #save
    ```
    
    Rsync between the old (`/var/lib/mysql`) and the new (`/data/mysql`) locations:
    
    ```bash
    rsync -avz /var/lib/mysql/ /data/mysql
    ```
    
    Start MySQL: `systemctl start mysql`
    
10. Test the database again:
    

```bash
mysql =u root -p 
show variables like 'datadir';
show databases;
use example_database;
select * from todo_list;
```

## 2) MySQL 8.0 Installation - Ubuntu 22.04

1. Disable apparmor:

```bash
systemctl stop apparmor
systemctl disable apparmor

/etc/init.d/apparmor stop
update-rc.d -f apparmor remove
apt-get purge apparmor
reboot
```

2. Download repository from MySQL

```bash
wget <https://dev.mysql.com/get/mysql-apt-config_0.8.28-1_all.deb>
```

3. Install it

```bash
dpkg -i mysql-apt-config_0.8.28-1_all.deb
```

Select `MySQL 8.0`
Update `apt update` 
Install `apt-get install mysql-server` and choose `Use Legacy Authentication Method`
Check the version and login:

```bash
mysql -V
mysql -u root -p
```

4. Change the `datadir`:

Create the new directory: `mkdir -p /data/mysql`

Give permissions to the directory:

```bash
chown -R mysql:mysql /data/mysql
chmod 750 /data/mysql
```

Stop MySQL: `systemctl stop mysql`

Modify the MySQL configuration

```bash
vi /etc/mysql/mysql.conf.d/mysqld.cnf
```

Change:

```bash
datadir=/var/lib/mysql
#to 
datadir=/data/mysql
#save
```

Rsync between the old (`/var/lib/mysql`) and the new (`/data/mysql`) locations:

```bash
rsync -avz /var/lib/mysql/ /data/mysql
```

Start MySQL: `systemctl start mysql`

5. Test the installation:

```bash
mysql -V #should be 8.0.X
mysql -u root -p 
show variables like 'datadir';
show databases;
```

6. Change the password for the `root` user and permit doing SSH with the `root` user:

```bash
sudo passwd root 
vi /etc/ssh/sshd_config
```
Change `PermitRootLogin prohibit-password` to `PermitRootLogin yes`

Restart SSH:
```bash
systemctl restart ssh
systemctl restart sshd 
```



#  General Migration Plan 

1) Check the applications installed on the old server: 

```bash
pstree
```
2) Check the versions of the installed applications:

```bash
app_name --version
```

3) Check the configurations(files, passwords) of the installed applications.
4) Install on the new server all the application that are present on the old server with the same configurations.
5) Check if the versions and configurations are the same on both servers.
6) Make sure that the servers can communicate
```bash 
ip a
ping server_ip
```
7) Sync the data between the servers: ```

```bash
rsync -avz --delete /path/to/data/ user@new_server_ip:/path/to/data
```







# Adapted Migration Plan 

1) Check the applications installed on the old server: 

```bash
pstree
```
<details>
pstree
</details>
2) Check the versions of the installed applications:

   ```bash
```bash
mysql --version
```
<details>
mysql --version
</details>
3) Check the configurations(files, passwords) of the installed applications.

```bash

```
   <details>
   vi /etc/mysql/mysql.conf.d/mysqld.cnf
   </details>
4) Install on the new server all the application that are present on the old server with the same configurations.

# Show the data on MySQL 5.7 
## Upgrade MySQL 5.7 to 8.0

1. Download repository from MySQL

```bash
wget https://dev.mysql.com/get/mysql-apt-config_0.8.28-1_all.deb
```

2. Install it

```bash
dpkg -i mysql-apt-config_0.8.28-1_all.deb
```

Select `MySQL 8.0`
3. Remove the old repo:
```bash
rm /etc/apt/sources.list.d/mysql.list
```

Update `apt update`
Install `apt-get install mysql-server`
Keep the old configuration file (`n or enter`).


## Back To the original plan 
5)  Check if the versions and configurations are the same on both servers.
```bash
mysql --version
vi /etc/mysql/mysql.conf.d/mysqld.cnf
```
<details>
mysql --version
vi /etc/mysql/mysql.conf.d/mysqld.cnf
</details>
6) Make sure the servers can communicate: 

```bash
ping 
```
<details>
use ping
</details>
## 7) Synchronization

1. Preliminary checks on both servers:

```bash
mysql -u root -p 
show databases;
use example_database;
show tables;
select * from todo_list;
show variables like 'datadir';
systemctl status mysql 
mysql -V
```

2. Make sure the MySQL is stopped on both of the servers:

```bash
systemctl status mysql 
systemctl stop mysql 
systemctl status mysql #just to be sure that is stopped
```

3. On the old server use this `rsync` command:

```bash
rsync -avz --delete /data/mysql/ root@10.132.184.92:/data/mysql
```

4. Start MySQL on the new server:

```bash
systemctl start mysql 
```

5. Test to see if the migration succeeded. On the new server, run the following commands:

```bash
mysql -u root -p 
show databases;
use example_database;
show tables;
select * from todo_list;
```