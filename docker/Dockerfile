FROM osrf/ros:humble-desktop-full

RUN apt update && apt install -y \
    ros-humble-turtlebot3* \
    && rm -rf /var/lib/apt/lists/*

RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc
