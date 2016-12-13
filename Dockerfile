FROM node:6

RUN npm i -g elm bower

WORKDIR /app

COPY package.json /app
RUN npm i

COPY bower.json /app
RUN bower install --allow-root

COPY elm-package.json /app
RUN elm-package install -y

COPY webpack.config.js /app

VOLUME ["/app/node_modules", "/app/bower_components", "/app/elm-stuff"]

EXPOSE 8080
CMD ["npm", "start"]
