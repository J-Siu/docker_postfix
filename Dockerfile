FROM alpine:edge

LABEL version="3.7.2-r1"
LABEL maintainers="[John Sing Dao Siu](https://github.com/J-Siu)"
LABEL name="postfix"
LABEL usage="https://github.com/J-Siu/docker_postfix/blob/master/README.md"
LABEL description="Docker - Postfix with sasldb2 support"

RUN apk --no-cache add ca-certificates ca-certificates-bundle tzdata
RUN apk --no-cache add \
		cyrus-sasl \
		cyrus-sasl-crammd5 \
		cyrus-sasl-digestmd5 \
		cyrus-sasl-gs2 \
		cyrus-sasl-gssapiv2 \
		cyrus-sasl-login \
		cyrus-sasl-ntlm \
		cyrus-sasl-scram \
		postfix=3.7.2-r1 && \
	tar cjf /postfix.pkg.tgz -C /etc postfix && \
	rm -rf /etc/postfix

COPY docker-compose.yml env start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]
