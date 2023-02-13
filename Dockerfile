FROM node:lts-slim
RUN npm install -g @angular/cli
RUN ln -s /home/node/app/node_modules/.bin/ng /usr/bin/ng
USER node
WORKDIR /home/node/app
EXPOSE 4200 49153
CMD ["npm", "start"]

