#!/bin/bash

# Armazenar o diretório raiz do projeto
ROOT_DIR=$(pwd)

# Permitir conexão com o servidor X
xhost +local:docker

# Criar o arquivo .docker.xauth e adicionar as permissões necessárias
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# Nome da imagem do Docker
IMAGE_NAME=turtlebot3-ros-humble

# Definir o diretório de trabalho do container
HOST_WORK_PATH="$(pwd)/ros_packages"

# Definição do diretório de trabalho do container
CONTAINER_WORK_PATH="/root/ros2_ws/src"

# Definir o diretório de dador compartilhado entre o host e o container
HOST_DATA_PATH="$ROOT_DIR/shared_folder"

# Definição do diretório de dados do container
CONTAINER_DATA_PATH="/root/shared_folder"  # Changed to a more specific mount point

# Rodar o container com as configurações necessárias
docker run -it \
  --rm \
  --name turtlebot3_container \
  --privileged \
  --user=root \
  --network=host \
  --env="DISPLAY=$DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --env="XAUTHORITY=$XAUTH" \
  --volume="$XAUTH:$XAUTH" \
  --volume="$HOST_WORK_PATH:$CONTAINER_WORK_PATH:rw" \
  --volume="$HOST_DATA_PATH:$CONTAINER_DATA_PATH:rw" \
  $IMAGE_NAME

# Configurações adicionais
# Uncomment these lines if using an NVIDIA GPU
#   --runtime nvidia \
#   --gpus all \
#   --env="NVIDIA_VISIBLE_DEVICES=all" \
#   --env="NVIDIA_DRIVER_CAPABILITIES=all" \
