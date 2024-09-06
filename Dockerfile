FROM openjdk:17-jdk-alpine

# Container'da çalışma dizinini ayarlayın
WORKDIR /app

# Mevcut dizin içeriğini container'a kopyalayın
COPY . /app

# Uygulamayı çalıştırın
CMD ["java", "-jar", "target/spring-petclinic-3.3.0-SNAPSHOT.jar"]
