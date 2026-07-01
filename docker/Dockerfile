# --- ETAPA 1: Build (Clonar e Compilar com Maven) ---
FROM maven:3.9.6-eclipse-temurin-17-alpine AS builder
RUN apk add --no-cache git
WORKDIR /app
RUN git clone https://github.com/Anajuliabm248/Livraria_Antiqua.git .
RUN mvn clean package -DskipTests

# --- ETAPA 2: Produção (Servidor Tomcat 10) ---
FROM tomcat:10.1-jdk17-temurin AS runner

WORKDIR /usr/local/tomcat/webapps/
RUN rm -rf ./ROOT ./docs ./examples
COPY --from=builder /app/target/trabalho_final.war ./ROOT.war

ENV CATALINA_OUT=/usr/local/tomcat/logs/catalina.out

EXPOSE 8080

ENTRYPOINT ["catalina.sh", "run"]
