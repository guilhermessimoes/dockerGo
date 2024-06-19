FROM golang:1.16-alpine as builder

WORKDIR /app

COPY . .

# Instalar UPX para compressão do binário
RUN apk add --no-cache upx

# Compile o binário Go estaticamente com otimizações
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o fullcycle-go . && \
    upx --best --ultra-brute fullcycle-go

FROM scratch

WORKDIR /app
COPY --from=builder /app/fullcycle-go /app/fullcycle-go
COPY index.html /app/index.html

EXPOSE 8000

CMD ["/app/fullcycle-go"]
