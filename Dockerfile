FROM alpine:edge

LABEL version="3.10.6-r0"
LABEL maintainers="[John Sing Dao Siu](https://github.com/J-Siu)"
LABEL name="postfix"
LABEL usage="https://github.com/J-Siu/docker_postfix/blob/master/README.md"
LABEL description="Docker - Postfix with sasldb2 support"
LABEL blog="[Tiny VPS Postfix with Docker](//johnsiu.com/blog/tiny-vps-postfix-docker/)"

COPY docker-compose.yml env start.sh /
RUN apk --no-cache add \
postfix=3.10.6-r0 \
	ca-certificates \
	ca-certificates-bundle \
	cyrus-sasl \
	cyrus-sasl-crammd5 \
	cyrus-sasl-digestmd5 \
	cyrus-sasl-gs2 \
	cyrus-sasl-gssapiv2 \
	cyrus-sasl-login \
	cyrus-sasl-ntlm \
	cyrus-sasl-scram \
	tzdata \
	&& tar cjf /postfix.pkg.tgz -C /etc postfix \
	&& rm -rf /etc/postfix \
	&& chmod +x /start.sh

CMD ["/start.sh"]
