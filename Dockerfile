# ref: https://github.com/pytorch/pytorch/blob/master/Dockerfile
# https://hub.docker.com/r/nvidia/cuda
# https://gitlab.com/nvidia/container-images/cuda/blob/master/doc/supported-tags.md

FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04
# ENV TZ="Asia/Seoul"  # Debian
ARG DEBIAN_FRONTEND=noninteractive
ARG PYTHON_VERSION=3.10

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         wget \
         ccache \
         ca-certificates \
         libjpeg-dev \
         vim \
         libpng-dev \
         fonts-powerline && \
     rm -rf /var/lib/apt/lists/*

RUN /usr/sbin/update-ccache-symlinks
RUN mkdir /opt/ccache && ccache --set-config=cache_dir=/opt/ccache

# ZSH install and setup
RUN apt-get update && apt-get upgrade -y && apt-get install -y zsh && \
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended && \
    chsh -s $(which zsh)
RUN wget https://raw.githubusercontent.com/caiogondim/bullet-train.zsh/master/bullet-train.zsh-theme -O /root/.oh-my-zsh/custom/themes/bullet-train.zsh-theme
RUN sed -i 's/robbyrussell/bullet-train/g' ~/.zshrc

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-/root/.oh-my-zsh/custom}/plugins/zsh-autosuggestions --depth=1
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-/root/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting --depth=1
RUN sed -i 's/(git)/(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

# RUN git clone https://github.com/wting/autojump.git /opt/autojump
# RUN /bin/zsh -c "cd /opt/autojump && ./install.py"

COPY requirements.txt .

# Install Conda
RUN curl -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh

# Miniconda Setup
RUN /opt/conda/bin/conda config --add channels pytorch && \
    /opt/conda/bin/conda config --add channels conda-forge && \
    /opt/conda/bin/conda config --remove channels defaults && \
    /opt/conda/bin/conda config --set channel_priority strict
     
RUN /opt/conda/bin/conda install -y python=$PYTHON_VERSION && \
    /opt/conda/bin/python -mpip install -r requirements.txt && \
    /opt/conda/bin/conda clean -ya
     
ENV PATH /opt/conda/bin:$PATH
# RUN echo "/opt/conda/bin:$PATH" >> ~/.zshrc
RUN conda init zsh
RUN wget https://raw.githubusercontent.com/EadCat/Server-Setup/master/bullet-train.zsh-theme -O ${ZSH_CUSTOM:-/root/.oh-my-zsh/custom}/themes/bullet-train.zsh-theme
RUN wget https://raw.githubusercontent.com/EadCat/Server-Setup/master/.condarc -O ~/.condarc

