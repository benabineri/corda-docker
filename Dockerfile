FROM debian:9

RUN apt-get -qq update && apt-get -y install gnupg

# Pull Zulu OpenJDK binaries from official repository:
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
RUN echo "deb http://repos.azulsystems.com/debian stable  main" >> /etc/apt/sources.list.d/zulu.list
RUN apt-get -qq update && apt-get -y install zulu-8

# Add Corda
RUN mkdir /opt/corda
ADD http://jcenter.bintray.com/net/corda/corda/2.0.0/corda-2.0.0.jar /opt/corda/corda.jar

VOLUME /mnt/vol
RUN ln -s /mnt/vol/node.conf /opt/corda/node.conf

WORKDIR /opt/corda
ENTRYPOINT ["java", "-jar", "corda.jar" ]
