#!/bin/bash

# zacurr, from python base docker image, create container 

docker run --runtime=nvidia --gpus all -it --ipc=host -v /mnt/aplproj/datasets:/Datasets --name deepbrush:py3.10-cuda11.8-cudnn8 /bin/zsh


