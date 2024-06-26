#!/bin/bash

# zacurr, from python base docker image, create container 

sudo docker run --runtime=nvidia --gpus all -it --ipc=host -v /home/eadyoung:/home/eadyoung:rw --name eadbase zsh_py3.10:cuda11.8 /bin/zsh


