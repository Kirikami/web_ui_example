FROM nginx:stable

MAINTAINER Ruslan Naumenko

RUN echo deb http://debian.xtdv.net/debian jessie main > /etc/apt/sources.list
RUN echo 'deb http://ftp.debian.org/debian/ stable main contrib non-free' >>/etc/apt/sources.list
RUN apt-get update

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update
RUN apt-get install -y oracle-java8-installer

COPY allure-commandline/ /allure-commandline/
RUN ln -s /allure-commandline/bin/allure /usr/bin/allure

COPY default.conf /etc/nginx/conf.d/default.conf

COPY generate_report.sh ./home/uitests/public_app_ui/generate_report.sh
RUN chmod +x /home/uitests/public_app_ui/generate_report.sh
RUN ln -s /home/uitests/public_app_ui/generate_report.sh /usr/bin/generate_report

RUN echo "export TERM=xterm" >> ~/.bashrc \
    echo "export VISIBLE=now" >> /etc/profile

WORKDIR /home/uitests/public_app_ui
RUN apt-get install -y vim
Run apt-get install -y nano
