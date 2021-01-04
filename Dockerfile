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
RUN yum install httpd -y
ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]

RUN cd var
RUN mkdir www && cd www
RUN mkdir html 

RUN cd ~/

COPY assets/ /assets/
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

EXPOSE 8080
CMD [ "npm", "start" ]
