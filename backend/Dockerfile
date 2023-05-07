
FROM node:19-bullseye

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

COPY package*.json ./


RUN npm install

COPY . .

EXPOSE 80

CMD [ "npm", "run", "start" ]