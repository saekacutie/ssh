FROM alpine:latest
RUN apk add --no-cache openssh bash python3 py3-pip \
    && pip3 install websockify flask --break-system-packages \
    && ssh-keygen -A \
    && echo "root:prvtspyyy" | chpasswd
COPY . .
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
