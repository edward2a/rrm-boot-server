#!/usr/bin/env bash


start_services() {
    service rsyslog start
    service isc-dhcp-server start
    service tftpd-hpa start
}

check_services() {
    fail=0
    service rsyslog status &>/dev/null|| fail=$((fail+1))
    service isc-dhcp-server status &>/dev/null || fail=$((fail+1))
    service tftpd-hpa status &>/dev/null || fail=$((fail+1))
    service nginx start &>/dev/null || fail=$((fail+1))
    return $fail
}

start_services
while true; do
    status=$(check_services; echo $?)
    [ $status -gt 0 ] && exit $status
    sleep 300
done

