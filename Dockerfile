FROM node:19-bullseye

COPY . .

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

RUN cd backend && npm install

EXPOSE 80

CMD [ "npm", "run", "start" ]