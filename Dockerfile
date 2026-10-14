FROM nginx:alpine
ARG VERSION=blue
COPY ${VERSION}/index.html /usr/share/nginx/html/index.html
