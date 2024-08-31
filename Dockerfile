# Use a base image with JDK 17
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Install Git and Maven
RUN apt-get update && apt-get install -y git maven

# Clone the Spring Petclinic repository
RUN git clone https://github.com/spring-projects/spring-petclinic.git

# Set the working directory to the cloned repository
WORKDIR /app/spring-petclinic

# Build the project using Maven
RUN ./mvnw package

# Expose the port the application will run on
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "target/spring-petclinic*.jar"]
