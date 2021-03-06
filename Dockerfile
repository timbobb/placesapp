FROM node:carbon


# Create app directory
#WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)

FROM centos:7

#MAINTAINER The CentOS Project <cloud-ops@centos.org>

LABEL Vendor="CentOS" \
    License=GPLv2 \
    Version=2.4.6-40

RUN yum update -y
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all
ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]

RUN cd var
RUN mkdir www && cd www
RUN mkdir html 

RUN cd ~/

COPY assets/ /var/www/html/assets/
COPY package*.json /var/www/html
COPY Dockerfile /var/www/html
COPY Jenkinsfile /var/www/html
COPY travel.html /var/www/html
COPY services.yml /var/www/html
COPY services.html /var/www/html
COPY pods.yml /var/www/html
COPY onepage.html /var/www/html
COPY index.html /var/www/html
COPY contact.html /var/www/html
COPY city-guides.html /var/www/html
COPY changeTag.sh /var/www/html
COPY buildspec.yml /var/www/html
COPY README.txt /var/www/html
COPY README.md /var/www/html


#RUN yum -y yum install epel-release
#RUN yum -y yum install nodejs
#RUN yum -y yum install npm
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

EXPOSE 80 8080

# Simple startup script to avoid some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]
