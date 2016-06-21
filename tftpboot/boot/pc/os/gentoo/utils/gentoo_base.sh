#!/bin/bash

base_url='http://distfiles.gentoo.org/releases/amd64/autobuilds'

get_current_stage3() {
    url="${base_url}/latest-stage3-amd64.txt"
    data=$(wget -qO- ${url})
}
