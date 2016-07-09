FROM debian

# install dhcpd and tftpd
RUN apt-get update && apt-get install -yq \
        isc-dhcp-server \
        tftpd-hpa \
        rsyslog

# cleanup configs
RUN rm -rf /etc/dhcp/*
RUN rm -f /etc/default/tftpd-hpa

# install configurations
ADD configs/dhcpd.conf /etc/dhcp/dhcpd.conf
ADD configs/tftpd-hpa /etc/default/tftpd-hpa

# install main runner script and make it executable
ADD scripts/main.sh /sbin/main.sh
RUN chmod 755 /sbin/main.sh

# default startup
ENTRYPOINT ["/sbin/main.sh"]
