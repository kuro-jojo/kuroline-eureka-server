# Use an official Maven image as the base image
FROM jelastic/maven:3.9.5-openjdk-21 AS build
# Set the working directory in the container
WORKDIR /app
# Copy the pom.xml and the project files to the container
COPY pom.xml .
COPY src ./src
# Build the application using Maven
RUN mvn clean package -DskipTests

FROM openjdk:24-jdk-slim
LABEL com.kuro.kuroline.author="Jonathan - kurojojo08@gmail.com"
WORKDIR /app
# Copy the built JAR file from the previous stage to the container
COPY --from=build /app/target/kuroline-eureka-server-1.0.0.jar /app/app.jar
ENTRYPOINT [ "java", "-jar", "app.jar" ]