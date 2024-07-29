#!/bin/bash

# zacurr, from python base docker image, create container 

docker run --runtime=nvidia --gpus all -it --ipc=host -u $(id -u):$(id -g) -v /mnt/aplhome/eadyoung/:/eadyoung -v /mnt/aplproj/datasets:/Datasets --name deepbrush:py3.10-cuda11.8-cudnn8 /bin/zsh


