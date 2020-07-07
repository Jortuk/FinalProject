FROM openjdk:15-jdk-alpine
RUN mkdir /opt/petclinic/
COPY . /opt/petclinic/
WORKDIR /opt/petclinic/
ARG url
ARG username
ARG password
ENV url=$url
ENV username=$username
ENV password=$password
EXPOSE 9966
CMD ["./mvnw", "spring-boot:run"]
