FROM openjdk:8-jre-buster

#################################################################
RUN echo 'deb-src http://deb.debian.org/debian buster main' >> /etc/apt/sources.list
RUN echo 'deb-src http://security.debian.org/debian-security buster/updates main' >> /etc/apt/sources.list
RUN echo 'deb-src http://deb.debian.org/debian buster-updates main' >> /etc/apt/sources.list
RUN apt update
RUN apt install build-essential git zlib1g-dev gcc make cmake -y
RUN apt build-dep openssl -y
RUN git clone https://github.com/rbsec/sslscan.git
WORKDIR sslscan/
RUN make static
RUN make install
WORKDIR /
#################################################################

#Copy the war.
ARG JAR_FILE=target/app.jar
COPY ${JAR_FILE} app.jar

#Setup the default log4j2.conf.
ARG LOG4J2_FILE=src/main/resources/log4j2-spring.xml
COPY ${LOG4J2_FILE} /conf/log4j2.xml

CMD ["java", "-Dlogging.config=/conf/log4j2.xml","-jar","/app.jar"]
