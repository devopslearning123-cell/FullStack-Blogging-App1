# FROM eclipse-temurin:17-jdk-alpine
    
# EXPOSE 8080
 
# ENV APP_HOME /usr/src/app

# COPY target/*.jar $APP_HOME/app.jar

# WORKDIR $APP_HOME

# CMD ["java", "-jar", "app.jar"]


# Building App
FROM maven:3.9.4-eclipse-temurin-17 AS build

WORKDIR /build


COPY pom.xml .
RUN mvn dependency:go-offline


COPY src ./src


RUN mvn clean package -DskipTests

# Creating Runtime Image
FROM eclipse-temurin:17-jdk-alpine

ENV APP_HOME=/usr/src/app
WORKDIR $APP_HOME

COPY --from=build /build/target/*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
