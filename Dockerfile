FROM openjdk:17-jdk-slim
WORKDIR /app
COPY ./target/* /elton
EXPOSE 8080
CMD ["java", "-jar", "/app/elton/*.jar"]

