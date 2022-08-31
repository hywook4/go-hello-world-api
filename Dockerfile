FROM golang:1.18.3-buster

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

# Export necessary port
EXPOSE ${port}

# Command to run when starting the container
CMD ["/build/main"]
