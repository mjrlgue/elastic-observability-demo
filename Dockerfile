#FROM adoptopenjdk/openjdk16
#FROM inovatrend/tomcat8-java8
#FROM danielyinanc/docker-jdk-6-tomcat7
FROM openjdk:8u322-jdk
ENV APP_HOME=/usr/app

# APM configuration
# ENV SERVICE_NAME="cardatabase"
# ENV APM_URL="https://apm-server-quickstart-apm-http.eck.svc:8200"
# ENV SECRET_TOKEN="tl2m108r2BxVt8h9J99EbB0l"
# ENV ENVIRONMENT="demo"
# ENV APPLICATION_PACKAGES="org.demo.carapp"

WORKDIR $APP_HOME

COPY target/cardatabase*.jar app.jar
# COPY target/elastic-apm-agent-latest-*.jar apm-agent.jar
COPY target/elastic-apm-agent-1.23.0.jar apm-agent.jar


CMD java -javaagent:apm-agent.jar \
     -Delastic.apm.service_name=${SERVICE_NAME} \
     -Delastic.apm.server_urls=${APM_URL} \
     -Delastic.apm.secret_token=${SECRET_TOKEN} \
     -Delastic.apm.environment=${ENVIRONMENT} \
     -Delastic.apm.global_labels=project=kappa \
     -Delastic.apm.application_packages=${APPLICATION_PACKAGES} \
     -Delastic.apm.verify_server_cert=false \
     -jar app.jar
