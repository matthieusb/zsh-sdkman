FROM ubuntu:18.04

# -- Env variables
ENV TERM "xterm-256color"
ENV SDKMAN_DIR "/root/.sdkman"
ENV ZSH_SDKMAN_CANDIDATES_DIR "/root/.zsh-sdkman/candidates"
ENV DOCKERIZE_VERSION "v0.6.1"

# -- apps install
RUN apt-get update
RUN apt-get install -y zsh wget curl git unzip zip apt-utils

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# -- zsh/oh-my-zsh configuration
WORKDIR /root
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
COPY ./.zshrc .
RUN zsh

# -- zsh-sdkman plugin install
WORKDIR .oh-my-zsh/custom/plugins
RUN git clone https://github.com/matthieusb/zsh-sdkman.git

# -- shunit install
WORKDIR /root

RUN wget https://github.com/kward/shunit2/archive/v2.1.7.tar.gz -O shunit.tar.gz
RUN tar -xvf shunit.tar.gz
RUN rm shunit.tar.gz
RUN mv shunit2-2.1.7 shunit

# -- sdkman install
WORKDIR /root

RUN curl -s "https://get.sdkman.io" | bash
RUN /bin/bash -c "source '.sdkman/bin/sdkman-init.sh' && sdk version"

# # Disabled for now, because installing only one version seems to install 2. No reason found
# RUN /bin/bash -c "source '.sdkman/bin/sdkman-init.sh' && sdk install java 12.0.1-open"

RUN /bin/bash -c "source '.sdkman/bin/sdkman-init.sh' && sdk install maven 3.3.9 && sdk install maven 3.5.0"

# -- adding test script and configuring for zsh
COPY ./launch_tests.sh .
COPY ./candidates_tests.sh .
RUN chmod +x ./launch_tests.sh
RUN chmod +x ./candidates_tests.sh

ENTRYPOINT zsh
