FROM nginx:stable 
WORKDIR /etc/nginx/
RUN rm -rf /etc/nginx/conf.d/default.conf
COPY ./reverse_proxy.conf ./conf.d/