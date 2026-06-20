FROM maven:3.9-eclipse-temurin-21 AS builder   
RUN apt-get update && apt-get upgrade -y 
WORKDIR /app
COPY . . 
RUN  mvn clean package 

FROM eclipse-temurin:21-jre-alpine 
WORKDIR /app 
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
