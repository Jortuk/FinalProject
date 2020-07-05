FROM node:current-alpine3.12
RUN mkdir /opt/petclinic/
WORKDIR /opt/petclinic/
COPY package.json /opt/petclinic/package.json
RUN npm install
RUN npm install -g @angular/cli@latest
COPY . /opt/petclinic/
EXPOSE 4200
CMD ng serve --host 0.0.0.0 --port 4200 --disableHostCheck true