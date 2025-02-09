# # Use an official OpenJDK runtime as a base image
# FROM openjdk:17-jdk-slim
#
# # Set the working directory inside the container
# WORKDIR /app
#
# # Copy the application JAR file into the container
# COPY target/*.jar app.jar
#
# # Expose the port your Spring Boot app runs on
# EXPOSE 8081
#
# # Command to run the application
# CMD ["java", "-jar", "app.jar"]
# FROM maven:3.8.5-openjdk-17 AS build
# COPY . .
# RUN mvn clean package -DskipTests
#
# FROM openjdk:17.0.1-jdk-slim
# COPY --from=build /target/email-writer-sb-0.0.1-SNAPSHOT.jar email-writer-sb.jar
# EXPOSE 8081
# ENTRYPOINT ["java","-jar","email-writer-sb"]

# Build Stage
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Run Stage
FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/email-writer-sb-0.0.1-SNAPSHOT.jar email-writer-sb.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "email-writer-sb.jar"]
