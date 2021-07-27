FROM node:alpine

WORKDIR '/home/node/app'
RUN chown node /home/node/app

USER node
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node . .
CMD ["npm", "run", "build"]

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=0 /home/node/app/build /usr/share/nginx/html
