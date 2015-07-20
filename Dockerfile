#
# Consul Nginx
#
FROM 		nginx:1.9.2
MAINTAINER 	Corbin Uselton <corbinu@decimal.io>

ENV CONSUL_TEMPLATE_VERSION 0.10.0
ENV TERM xterm

RUN apt-get update && apt-get install -y curl nano

RUN curl -SLO "https://github.com/hashicorp/consul-template/releases/download/v$CONSUL_TEMPLATE_VERSION/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tar.gz" \
	&& tar -xzf consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tar.gz -C /usr/local/bin --strip-components=1 \
	&& rm "consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tar.gz"

COPY bin/* /usr/local/bin/
COPY load-balance.ctmpl /load-balance.ctmpl

RUN rm -f /etc/nginx/conf.d/default.conf

EXPOSE 80

ENTRYPOINT ["nginx-start"]
CMD ["load-balance"]
