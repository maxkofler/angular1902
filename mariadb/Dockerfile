FROM node:14-alpine3.16
RUN adduser -D USER
RUN apk add bash git vim mariadb-client
WORKDIR root
RUN npm install -g "@angular/cli@12.0.4"
RUN npm install -g nodemon
