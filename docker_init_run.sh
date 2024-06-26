#!/bin/bash

# zacurr, from python base docker image, create container 

sudo docker run -it --ipc=host -v /home/eadyoung:/home/eadyoung:rw -v /data1:/data1:rw -v /data2:/data2:rw -v /data3:/data3:rw -v /data4:/data4:rw -v /data5:/data5:rw -v /data6:/data6:rw -v /data7:/data7:rw -v /data8:/data8:rw --name eadbase zsh_py3.10:cuda11.8 /bin/zsh


