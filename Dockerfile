FROM debian:stable-slim

RUN apt-get update --quiet \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
		apt-cacher-ng \
	&& sed -i /etc/apt-cacher-ng/acng.conf \
		-e 's/# ForeGround: 0/ForeGround: 1/' \
	&& (echo 'http://deb.debian.org/debian/' > /etc/apt-cacher-ng/backends_debian) \
	&& (echo 'http://archive.ubuntu.com/ubuntu/' > /etc/apt-cacher-ng/backends_ubuntu) \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 3142/tcp
CMD ["/usr/sbin/apt-cacher-ng", "-c", "/etc/apt-cacher-ng"]
