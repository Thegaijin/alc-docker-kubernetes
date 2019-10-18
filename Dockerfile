FROM node:8-alpine as builder

RUN apk update \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app/
RUN npm install
RUN npm run build

FROM nginx:1.15.8-alpine

COPY --from=builder /app/nginx/default.conf /etc/nginx/conf.d/
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/build /usr/share/nginx/html
