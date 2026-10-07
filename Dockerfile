# syntax=docker/dockerfile:1

FROM maven:3.9.9-eclipse-temurin-8 AS build
WORKDIR /workspace

ARG DB_HOST=mysql
ARG DB_NAME=cd_store
ARG DB_USER=root
ARG DB_PASSWORD=1122

COPY pom.xml ./
COPY src ./src
COPY WebContent ./WebContent

RUN sed -i "s|jdbc:mysql://localhost:3306/cd_store?useSSL=false&serverTimezone=UTC|jdbc:mysql://${DB_HOST}:3306/${DB_NAME}?useSSL=false\&serverTimezone=UTC|g" WebContent/WEB-INF/SQL/DB.xml \
    && sed -i "s|<jdbcuser>root</jdbcuser>|<jdbcuser>${DB_USER}</jdbcuser>|g" WebContent/WEB-INF/SQL/DB.xml \
    && sed -i "s|<jdbcpwd>1122</jdbcpwd>|<jdbcpwd>${DB_PASSWORD}</jdbcpwd>|g" WebContent/WEB-INF/SQL/DB.xml \
    && mvn -B -DskipTests clean package

FROM tomcat:9.0-jre8
WORKDIR /usr/local/tomcat

RUN rm -rf webapps/*
COPY --from=build /workspace/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
