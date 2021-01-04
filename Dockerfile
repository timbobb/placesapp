FROM node:carbon


# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY assets/ /assets/
COPY package*.json ./
COPY Dockerfile ./
COPY Jenkinsfile ./
COPY travel.html ./
COPY services.yml ./
COPY services.html ./
COPY pods.yml ./
COPY onepage.html ./
COPY index.html ./
COPY pcontact.html ./
COPY city-guides.html ./
COPY changeTag.sh ./
COPY buildspec.yml ./
COPY README.txt ./
COPY README.md ./


RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "npm", "start" ]
