##### Build Image #####
FROM ghcr.io/rrglobal/sf-node:latest AS builder
USER root
# FROM node AS builder
WORKDIR /app

# Copy the source code
COPY . .

# Install dependencies
RUN yarn
RUN yarn build

##### Runtime Image #####
FROM ghcr.io/rrglobal/sf-nginx:latest AS final
USER root
# FROM nginx AS final
WORKDIR /app

COPY /nginx.conf /etc/nginx/nginx.conf
COPY /default.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app/cli-cjs.js /usr/share/nginx/html
COPY --from=builder /app/cli.js /usr/share/nginx/html
COPY --from=builder /app/deciduous-logo.png /usr/share/nginx/html
COPY --from=builder /app/deciduous-logo-dark.png /usr/share/nginx/html
COPY --from=builder /app/favicon.ico /usr/share/nginx/html
COPY --from=builder /app/index.html /usr/share/nginx/html
COPY --from=builder /app/layout.js /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
