
# Build stage
FROM rust:1.70-buster as builder

WORKDIR /app

# Accept the build argument
ARG DATABASE_URL

ENV DATABASE_URL=$DATABASE_URL


# Copy everything inside the root dir into the Docker image
COPY . .

RUN cargo build --release

# Production stage

FROM debian:buster-slim

WORKDIR /usr/local/bin

COPY --from=builder /app/target/release/rust-crud-api .

CMD ["./rust-crud-api"]
