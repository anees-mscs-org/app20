FROM golang:1.20-alpine AS build
ADD . /src
WORKDIR /src
RUN go get -d -v -t
RUN GOOS=linux GOARCH=amd64 go build -v -o app20 

FROM alpine:3.17.3
EXPOSE 8080
CMD ["app20"]
ENV VERSION 1.1.4
COPY --from=build /src/app20 /usr/local/bin/app20
RUN chmod +x /usr/local/bin/app20
