FROM golang:1.19 AS builder

WORKDIR /service

COPY . .

RUN go mod tidy && \
    CGO_ENABLED=0 GOOS=linux go build -ldflags '-extldflags "-static"' -o /go-proxy-service ./cmd/app/main.go


FROM alpine:3.10
COPY --from=builder /go-proxy-service /bin

CMD ["sh", "-c", "/bin/go-proxy-service"]