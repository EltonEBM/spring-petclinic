FROM openjdk:17-jdk-slim
WORKDIR .
EXPOSE 8080
CMD ["java", "-jar", "target/app.jar"]

