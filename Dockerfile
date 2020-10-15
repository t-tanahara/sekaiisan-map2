FROM node:14.13.1

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ENV HOST 0.0.0.0

RUN apt update && apt upgrade -y

WORKDIR /app
COPY ./package.json .
RUN npm install
COPY . .