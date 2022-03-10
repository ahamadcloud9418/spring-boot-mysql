# Maven build container 

FROM maven:3.8.2 openjdk-8 AS maven_build
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package


FROM openjdk
EXPOSE 8081
CMD java -jar /data/spring-boot-mysql-0.0.1-SNAPSHOT.jar
#copy spring-boot-mysql tdocker image from builder image
COPY --from=maven_build /tmp/target/spring-boot-mysql-0.0.1-SNAPSHOT.jar  /data/spring-boot-mysql-0.0.1-SNAPSHOT.jar
