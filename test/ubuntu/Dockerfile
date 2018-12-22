FROM ubuntu:18.04

# -- Env variables
ENV TERM "xterm-256color"
ENV SDKMAN_DIR "/root/.sdkman"

# -- apps install
RUN apt-get update
RUN apt-get install -y zsh wget curl git unzip zip apt-utils

# -- zsh/oh-my-zsh configuration
WORKDIR /root

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN zsh

# -- sdkman install
RUN curl -s "https://get.sdkman.io" | bash
RUN /bin/bash -c "source '.sdkman/bin/sdkman-init.sh' && sdk version"

# -- zsh-sdkman plugin install
WORKDIR .oh-my-zsh/custom/plugins


# RUN git clone https://github.com/matthieusb/zsh-sdkman.git
# COPY ./.zshrc .

ENTRYPOINT sh
