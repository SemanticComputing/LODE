FROM openjdk:8-jdk

ARG MAVEN_VERSION=3.5.3
ENV MAVEN_VERSION=${MAVEN_VERSION}

WORKDIR /opt/maven
RUN wget -O maven.tar.gz http://www.nic.funet.fi/pub/mirrors/apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    && tar --strip-components=1 -xzvf maven.tar.gz \
    && rm maven.tar.gz

ENV PATH "/opt/maven/bin:$PATH"

COPY . /app/

WORKDIR /app

EXPOSE 8080

RUN mvn clean install

CMD mvn jetty:run
