#!/usr/bin/env bash

nohup docker run --net=host --rm -v "$(pwd)/tftpboot:/tftpboot:ro" --name rrm_boot_server rrm_boot_server &>container.log &
