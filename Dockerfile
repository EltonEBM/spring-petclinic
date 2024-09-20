FROM openjdk:17-jdk-slim
WORKDIR /app
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
