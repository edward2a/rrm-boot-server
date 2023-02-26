FROM debian

# install apt configuration
ADD configs/apt_garbage /etc/apt/apt.conf.d/00nocrap

# install dhcpd and tftpd
RUN apt-get update && apt-get install -yq --no-install-recommends \
        isc-dhcp-server \
        tftpd-hpa \
        rsyslog \
        nginx \
        procps

# cleanup configs
RUN rm -rf /etc/dhcp/*
RUN rm -f /etc/default/tftpd-hpa
RUN rm -f /etc/nginx/sites-enabled/default

# install configurations
ADD configs/dhcpd.conf /etc/dhcp/dhcpd.conf
ADD configs/tftpd-hpa /etc/default/tftpd-hpa
ADD configs/nginx.conf /etc/nginx/conf.d/tftpboot.conf

# install main runner script and make it executable
ADD scripts/main.sh /sbin/main.sh
RUN chmod 755 /sbin/main.sh

# default startup
ENTRYPOINT ["/sbin/main.sh"]
