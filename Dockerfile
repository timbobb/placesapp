FROM node:carbon


# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
RUN yum -y install httpd -y
RUN systemctl start httpd
RUN systemctl enable httpd

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
COPY pcontact.html /var/www/html
COPY city-guides.html /var/www/html
COPY changeTag.sh /var/www/html
COPY buildspec.yml /var/www/html
COPY README.txt /var/www/html
COPY README.md /var/www/html


RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "npm", "start" ]
