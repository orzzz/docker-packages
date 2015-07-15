FROM tutum/debian:wheezy
RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN apt-get -y update
RUN apt-get -y install apt-spy
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
RUN apt-spy -t 2 -d wheezy
RUN echo "mysql-server-5.5 mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get -y install mysql-server-5.5 mysql-client
RUN apt-get -y install openssh-server
RUN echo "root:shuai6563" | chpasswd
ENV PATH $PATH:/usr/local/mysql/bin:/usr/local/mysql/scripts
RUN echo "[mysqld]" 					  >/etc/mysql/conf.d/docker.cnf
RUN echo "bind-address   = 0.0.0.0" 	 >>/etc/mysql/conf.d/docker.cnf
RUN echo "port = 3306" 					 >>/etc/mysql/conf.d/docker.cnf
RUN echo "basedir       = /usr" 		 >>/etc/mysql/conf.d/docker.cnf
RUN echo "datadir       = /var/lib/mysql">>/etc/mysql/conf.d/docker.cnf
RUN echo "serverid = 1" 				 >>/etc/mysql/conf.d/docker.cnf
RUN echo "key_buffer_size = 32M" 		 >>/etc/mysql/conf.d/docker.cnf
RUN echo "sort_buffer_size = 128K" 		 >>/etc/mysql/conf.d/docker.cnf
RUN echo "read_buffer_size = 128K" 		 >>/etc/mysql/conf.d/docker.cnf
RUN echo "join_buffer_size = 1M" 		 >>/etc/mysql/conf.d/docker.cnf
RUN echo "query_cache_size = 64M" 		 >>/etc/mysql/conf.d/docker.cnf
RUN echo "max_connections = 1000" 		 >>/etc/mysql/conf.d/docker.cnf
RUN echo "skip-name-resolve"             >>/etc/mysql/conf.d/docker.cnf
RUN echo "skip-locking"					 >>/etc/mysql/conf.d/docker.cnf
RUN echo "default-storage-engine=MyISAM" >>/etc/mysql/conf.d/docker.cnf
RUN echo "init_file = /etc/mysql/init"   >>/etc/mysql/conf.d/docker.cnf
RUN echo "GRANT ALL ON *.* TO ifishman@'%' IDENTIFIED BY 'shuai6563';" >/etc/mysql/init

ENTRYPOINT service mysql restart
