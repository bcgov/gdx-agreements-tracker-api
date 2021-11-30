FROM node:17-alpine3.12

WORKDIR /usr/scr/app
COPY package.json .
RUN npm i --production
COPY server.js .
COPY swagger.json .

EXPOSE 8080
CMD [ "node", "server.js" ]
