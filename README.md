# turtlebot3

Esse é um repositório para utilização do robô Turtlebot3 em simulação. 

## Requisitos

Utilizaremos Docker para rodar a simulação do Turtlebot3. Portanto, é necessário ter o Docker instalado em sua máquina. Para instalar o Docker, siga as instruções em https://docs.docker.com/get-docker/.

## Instalação

Primeiramente, clone o repositório:

```bash
git clone https://github.com/atwork-pequimecanico/turtlebot3.git
```

Em seguida, entre na pasta do repositório:

```bash
cd turtlebot3
```

Construa a imagem do Docker:

```bash
docker build -t turtlebot3-ros-humble -f docker/Dockerfile .
```

## Execução

Inicialmente iremos utilizar a simulação virtual do Turtlebot3, que é feita utilizando o RViz. Para rodar a simulação, na raiz do repositório, execute o script `run.sh`:

```bash
./run.sh
``` 

Execute `turtlebot3_fake_node.launch.py` no pacote `turtlebot3_fake_node`, que é um nó de simulação simples. Você pode especificar o modelo do robô(`burger`, `waffle`, `waffle_pi`) através da variável de ambiente `TURTLEBOT3_MODEL`.

```bash
export TURTLEBOT3_MODEL=burger
ros2 launch turtlebot3_fake_node turtlebot3_fake_node.launch.py
```

Em seguida, em outro terminal, execute o comando docker para acessar o container:

```bash
docker exec -it turtlebot3_container bash
```

E, então, execute `turtlebot3_teleop_key.launch.py` no pacote `turtlebot3_teleop`, que é um nó para controlar o robô com o teclado.

```bash
export TURTLEBOT3_MODEL=burger
ros2 run turtlebot3_teleop teleop_keyboard
```

É possível visualizar as informações de odometria do robô utilizando o comando `ros2 topic echo` dentro do container. Abra um novo terminal, acesse o container e execute o comando:

```bash
ros2 topic echo /odom
```