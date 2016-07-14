#!/usr/bin/env bash

date_tag=$(date +%Y%M%d%H%m%S)

docker build -t rrm_boot_server:${date_tag} .

docker tag rrm_boot_server:${date_tag} rrm_boot_server:latest
