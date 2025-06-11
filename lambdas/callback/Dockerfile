FROM node:18

WORKDIR /var/task

COPY package*.json ./
RUN npm install

COPY index.js ./

CMD ["node", "index.js"]