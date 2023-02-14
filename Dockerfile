FROM node:lts-slim
RUN npm install -g @angular/cli
USER node
WORKDIR /home/node/app
EXPOSE 4200 49153
CMD ["npm", "start"]

