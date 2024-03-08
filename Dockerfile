# Stage 1: Build the BGPalerter binary
FROM node:18.19.0-alpine as build
WORKDIR /opt/bgpalerter
COPY . .
RUN npm install && /bin/sh build.sh

# Stage 2: Setup the runtime environment
FROM alpine:latest
WORKDIR /opt/bgpalerter

# Copy compiled binary and config from build stage
COPY --from=build /opt/bgpalerter/bin/bgpalerter-linux-x64 ./bgpalerter-linux-x64
COPY --from=build /opt/bgpalerter/config.yml ./config.yml

# Setup permissions and directories
RUN chmod +x bgpalerter-linux-x64 && \
    mkdir prefixes alerts

# Execute BGPalerter
CMD ["./bgpalerter-linux-x64"]

