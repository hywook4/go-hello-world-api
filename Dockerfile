# Stage 1 - Build Go binary
# Set build environment
FROM golang:1.18.3-buster as build-env

# Set necessary environmet variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

ARG entry_path=main.go

# Move to working directory /build
WORKDIR /build

# Copy and download dependency using go mod
COPY go.mod .
COPY go.sum .
RUN go mod download

# Copy the code into the container
COPY . .

# Build the application
RUN go build ${entry_path}

####

# Stage 2 - Run Go application
# Set running environment
FROM scratch

ARG port=8080

# Move to working directory /app
WORKDIR /app

# Copy the built Go binary
COPY --from=build-env /build/main /app/main

# Export necessary port
EXPOSE ${port}

# Command to run when starting the container
CMD ["/app/main"]
