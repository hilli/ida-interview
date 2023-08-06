FROM --platform=$BUILDPLATFORM golang:latest as builder

ARG TARGETARCH
ARG TARGETOS
ENV GO111MODULE=on GOOS=$TARGETOS GOARCH=$TARGETARCH

WORKDIR /ida
COPY . /ida
RUN CGO_ENABLED=0 \
  go build -a -tags netgo \
  -ldflags '-w -extldflags "-static"' \
  -o webserver

FROM scratch
LABEL org.opencontainers.image.source http://github.com/hilli/ida-interview
COPY --from=builder /ida/webserver .
COPY static static
ENTRYPOINT ["/webserver"]
EXPOSE 8080
