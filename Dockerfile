FROM golang:1.18.3-buster as build-env

ARG port=8080

# Move to working directory /build
WORKDIR /build

# Copy and download dependency using go mod
COPY go.mod .
COPY go.sum .
RUN go mod download

# Copy the code into the container
COPY . .

# Build the application
RUN go build main.go


FROM arm64v8/ubuntu

WORKDIR /app

COPY --from=build-env /build/main /app/main

EXPOSE 8080

CMD ["/app/main"]