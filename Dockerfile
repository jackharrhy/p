# build

FROM crystallang/crystal:0.31.11 as crystalbuilder

WORKDIR /src
COPY shard.* /src/
COPY /src/ /src/
COPY .env.dist /src/.env

RUN shards
RUN crystal build src/bot.cr --release --static -o bot

# prod

FROM alpine:3

WORKDIR /app
COPY --from=crystalbuilder /src/bot /app/bot

CMD ["/app/bot"]
