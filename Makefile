date_tag = $(shell date +%Y%M%d%H%m%S)
pwd = $(shell pwd)

all: build start

build:
	docker build -t rrm_boot_server:${date_tag} .
	docker tag rrm_boot_server:${date_tag} rrm_boot_server:latest

start:
	nohup docker run --net=host --rm -v "$(pwd)/tftpboot:/tftpboot:ro" --name rrm_boot_server rrm_boot_server &>container.log &

stop:
	docker stop rrm_boot_server

test:
