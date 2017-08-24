date_tag = $(shell date +%Y%M%d%H%m%S)
pwd = $(shell pwd)

all: docker_build docker_start

docker_build:
	docker build -t rrm_boot_server:${date_tag} .
	docker tag rrm_boot_server:${date_tag} rrm_boot_server:latest

docker_start:
	nohup docker run --net=host --rm -v "$(pwd)/tftpboot:/tftpboot:ro" --name rrm_boot_server rrm_boot_server &>container.log &

docker_stop:
	-docker stop rrm_boot_server

docker_restart: docker_stop docker_start
