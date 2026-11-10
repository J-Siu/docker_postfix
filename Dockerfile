FROM alpine:edge
ARG APP="postfix"
ARG VER="3.11.7-r0"
ARG USR="https://github.com/J-Siu"
LABEL version=${VER}
LABEL maintainers="[John Sing Dao Siu](${USR})"
LABEL name=${APP}
LABEL usage="${USR}/docker_${APP}/blob/master/README.md"
LABEL description="Docker - Postfix with sasldb2 support"
LABEL blog="[Tiny VPS Postfix with Docker](//johnsiu.com/blog/tiny-vps-postfix-docker/)"

COPY docker-compose.yml env start.sh /
RUN apk --no-cache add \
${APP}=${VER} \
ca-certificates \
ca-certificates-bundle \
tzdata \
cyrus-sasl \
cyrus-sasl-crammd5 \
cyrus-sasl-digestmd5 \
cyrus-sasl-gs2 \
cyrus-sasl-gssapiv2 \
cyrus-sasl-login \
cyrus-sasl-ntlm \
cyrus-sasl-scram \
&& tar cjf /postfix.pkg.tgz -C /etc postfix \
&& rm -rf /etc/postfix \
&& chmod +x /start.sh

CMD ["/start.sh"]
