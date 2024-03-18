# Use a minimal base image
FROM golang:1.17-alpine

RUN mkdir /app

# Copy the local package files to the container's workspace
ADD . /app

# Set the working directory inside the container
WORKDIR /app

# Build the Go application
RUN go build -o hello .

# Run the executable
CMD ["app/hello"]