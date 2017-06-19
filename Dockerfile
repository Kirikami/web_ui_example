FROM ubuntu:16.04

ENV TERM xterm

USER root

#================================================
# Customize sources for apt-get
#================================================
RUN  echo "deb http://archive.ubuntu.com/ubuntu xenial main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu xenial-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu xenial-security main universe\n" >> /etc/apt/sources.list

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    bzip2 \
    ca-certificates \
    openjdk-8-jre-headless \
    sudo \
    unzip \
    wget \
    nano \
  && rm -rf /var/lib/apt/lists/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

#========================================
# Add normal user with passwordless sudo
#========================================
RUN sudo useradd uitests --shell /bin/bash --create-home \
  && sudo usermod -a -G sudo uitests \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'uitests:secret' | chpasswd

USER root

#===============
# Google Chrome
#===============
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install \
    google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/*

#==================
# Chrome webdriver
#==================
ENV CHROME_DRIVER_VERSION 2.30
RUN wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

#=================================
# Chrome Launch Script Modication
#=================================
COPY images/chrome/chrome_launcher.sh /opt/google/chrome/google-chrome
RUN chmod +x /opt/google/chrome/google-chrome

USER uitests
# Following line fixes
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

USER root

#=================================
# Intall RVM required packages
#=================================
RUN apt-get update -qqy && apt-get install -y curl patch gawk g++ gcc make libc6-dev patch \
  libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev \
  sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison \
  pkg-config libffi-dev

#=================================
# Install mysql ruby support
#=================================
RUN apt-get install -y ruby-mysql libmysqlclient-dev

#=================================
# Headless browser support
#=================================
RUN apt-get install -y \
  xvfb \
  libgconf-2-4 \
  gconf-service \
  libnspr4 \
  libnss3 \
  libasound2 \
  libpango1.0-0 \
  libxss1 \
  libxtst6 \
  fonts-liberation \
  libappindicator1 \
  xdg-utils

USER uitests

#RUN gpg --keyserver hkp://keys.gnupg.net:80 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

#=================================
# install RVM, Ruby, and Bundler
#=================================
RUN \curl -L https://get.rvm.io | bash -s
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.3.1"
RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN echo 'source ~/.rvm/scripts/rvm' >> ~/.bashrc

RUN mkdir ~/public_app_ui

COPY . /home/uitests/public_app_ui/

USER root

RUN echo "export TERM=xterm" >> ~/.bashrc \
    echo "export VISIBLE=now" >> /etc/profile

RUN chmod +x /home/uitests/public_app_ui/run_tests.sh
RUN ln -s /home/uitests/public_app_ui/run_tests.sh /usr/bin/run_tests

RUN chown -R uitests:uitests /home/uitests/public_app_ui/

USER uitests

RUN echo "export TERM=xterm" >> ~/.bashrc

WORKDIR /home/uitests/public_app_ui

RUN ["/bin/bash", "-c", "source ~/.rvm/scripts/rvm && gem install i18n -v '0.7.0' && gem install mimemagic -v '0.3.0' && bundle install"]

CMD ["sleep", "infinity"]
