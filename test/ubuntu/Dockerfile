FROM ubuntu:18.04
SHELL ["/bin/bash", "-c"]

# -- Env variables
env TERM 'xterm-256color'

# -- apps install
RUN apt-get update
RUN apt-get install -y zsh wget curl git unzip zip apt-utils

# -- zsh/oh-my-zsh configuration
WORKDIR /root

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN zsh

# -- sdkman install
RUN curl -s "https://get.sdkman.io" | bash
RUN source "/root/.sdkman/bin/sdkman-init.sh"
# RUN source ~/.zshrc
RUN /bin/bash -l -c "sdk version"

# -- zsh-sdkman plugin install
WORKDIR .oh-my-zsh/custom/plugins


# RUN git clone https://github.com/matthieusb/zsh-sdkman.git
# COPY ./.zshrc .
