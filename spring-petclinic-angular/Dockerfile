FROM node:v14.5.0
WORKDIR /app
COPY package.json /app/package.json
RUN npm install
RUN npm install -g @angular/core@8 @angular/cli@8

COPY . /app

CMD ng serve --host 0.0.0.0 --port 4200 --disableHostCheck true