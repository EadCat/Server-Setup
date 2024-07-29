#!/bin/bash

# zacurr, from python base docker image, create container 

docker run --runtime=nvidia --gpus all -it --ipc=host -u $(id -u):$(id -g) -v /home/user:/home/eadyoung:rw --name eadbase zsh_py3.10:cuda11.8 /bin/zsh


