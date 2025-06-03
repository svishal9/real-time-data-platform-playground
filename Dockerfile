FROM ubuntu:24.10
RUN apt-get update  \
        && apt-get install -y curl unzip netcat-traditional
RUN curl -L -o duckdb_cli.zip "https://github.com/duckdb/duckdb/releases/download/v1.3.0/duckdb_cli-linux-arm64.zip" \
      && unzip duckdb_cli.zip \
      && rm duckdb_cli.zip
ENTRYPOINT [ "/duckdb" ]