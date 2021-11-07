ARG ALPINE=alpine:3.12

FROM $ALPINE AS builder
WORKDIR /
COPY udpbroadcastrelay/main.c .
RUN apk add --no-cache gcc musl-dev linux-headers \
  && gcc -g main.c -o udpbroadcastrelay

FROM $ALPINE
WORKDIR /
COPY --from=builder /udpbroadcastrelay .
ENTRYPOINT ["./udpbroadcastrelay"]
