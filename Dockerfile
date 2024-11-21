##### Build Image #####
# simple unprotected image 
# FROM docker AS builder        
# secure image requires you to get a token from github
FROM ghcr.io/rrglobal/sf-node:latest AS builder 

# on secure, you need to switch to root to ensure sufficient permission
USER root
# FROM node AS builder
WORKDIR /app

# Copy the source code from local machine to builder WORKDIR
COPY . .

# Install dependencies
RUN yarn
RUN yarn build

##### Runtime Image #####
# simple unprotected image 
# FROM nginx AS final
# secure image requires you to get a token from github
FROM ghcr.io/rrglobal/sf-nginx:latest AS final
# on secure, you need to switch to root to ensure sufficient permission
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
