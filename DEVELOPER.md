# Decidiuous App

## Quick Start - Local Dev

To run the application locally, complete the following:

```sh
# install dependencies
yarn

# transpile the app from typescript to javascript
yarn build
```

As this point, you should see layout.ts turned into layout.js. The application should be capable of running. You can run locally through something like

```sh
npx live-server .
```

## Building and Running in Docker

The file Dockerfile is configured to create a proper image running nginx with the compiled application.

To use it, you build the image, then you inflate the container and then you can call the container on the port you choose.

```sh

#build the image
# when I tried this command, I get errors, perhaps because I'm not in some docker command line?
docker build -t deciduous:latest

# Run the image.  The 8888 represents container outside, 80 inside
# so you would call http://localhost:8888 and inside container it would run port 80
docker run -p 8888:80 deciduous:latest

# Run the image detached
docker run -d -p 8888:80 deciduous:latest
```

## Deploying the application

Random commands you can sort out later

```sh

# list the docker images defined and then grep searches for wildcard
docker image ls | grep dec

# use this type command to see which containers are running, you
docker container ls | grep dec

# use this command with the first few chars of sha found in docker container command
# this command deflates/stops the container, removes from running
docker stop 62b

# move the image to github image repository
# you can run this command more than once if you are making changes to image
docker tag deciduous:latest ghcr.io/rrglobal/deciduous:latest
```
