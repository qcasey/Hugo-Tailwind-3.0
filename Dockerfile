FROM node:17-buster

WORKDIR /usr/app
COPY ./ /usr/app

# Install hugo
ENV HUGO_VERSION 0.92.0
ENV HUGO_DOWNLOAD_URL https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN curl -L $HUGO_DOWNLOAD_URL | tar xzv hugo && \
	mv hugo /usr/bin/hugo

# Install npm
RUN npm install
RUN npm run build

FROM nginx
WORKDIR /usr/app
COPY --from=0 /usr/app/public /usr/share/nginx/html
