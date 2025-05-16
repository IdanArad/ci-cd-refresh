# Use the official Go image to build the app
FROM golang:1.24-alpine AS builder

# Set working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum to download dependencies
COPY go.mod ./
RUN go mod download

# Copy all source code
COPY . .

# Build the Go app into a binary called 'myapp'
RUN go build -o ci-cd-refresh-exec ./main

# Use a minimal base image to run the app
FROM alpine:latest

# Copy the compiled binary from builder stage
COPY --from=builder /app/ci-cd-refresh-exec .

# Make sure the executable has permission
RUN chmod +x ci-cd-refresh-exec

# Expose port (adjust as needed)
EXPOSE 8080

# Run the app binary
CMD ["./ci-cd-refresh-exec"]

