# Dockerfile for thrift - The Campus Exchange Web Application
FROM eclipse-temurin:21-jdk-alpine AS builder

WORKDIR /app

# Copy dependency libraries and sources
COPY lib ./lib
COPY src ./src
COPY web ./web

# Compile all Java sources
RUN mkdir bin && \
    find src/main/java -name "*.java" > sources.txt && \
    javac -encoding UTF-8 -d bin -cp "lib/*:bin" @sources.txt

# Runtime Stage
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

COPY --from=builder /app/bin ./bin
COPY --from=builder /app/lib ./lib
COPY --from=builder /app/web ./web
COPY db.properties ./db.properties

ENV PORT=8080
EXPOSE 8080

CMD ["java", "-cp", "bin:lib/*", "web.WebServer"]
