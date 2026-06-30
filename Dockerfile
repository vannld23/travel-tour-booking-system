# =========================================================
# Stage 1: Build WAR with Maven
# =========================================================
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy pom.xml riêng để cache dependencies
COPY TravelTourBooking/pom.xml ./pom.xml
RUN mvn dependency:go-offline -q

# Copy toàn bộ source code
COPY TravelTourBooking/src ./src

# Build WAR (bỏ qua tests)
RUN mvn clean package -DskipTests -q

# =========================================================
# Stage 2: Deploy lên Tomcat 10.1 + JDK 17
# =========================================================
FROM tomcat:10.1-jdk17-temurin

# Xóa ứng dụng mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR vào ROOT để app chạy tại "/"
COPY --from=builder /app/target/TravelTourBooking.war /usr/local/tomcat/webapps/ROOT.war

# Render dùng PORT 8080 mặc định
EXPOSE 8080

CMD ["catalina.sh", "run"]
