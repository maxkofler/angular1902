FROM node:14-alpine3.16
RUN apk add bash git vim
WORKDIR root
RUN npm install -g "@angular/cli@12.0.4"
RUN npm install -g nodemon
CMD sh
