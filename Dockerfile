FROM openjdk:17-jdk-slim
WORKDIR /app
RUN ./mvnw package
COPY . .
EXPOSE 8080
CMD ["java", "-jar", "/app/target/*.jar"]

