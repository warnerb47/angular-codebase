# Stage 1: Build the Angular app
FROM node:18-alpine3.17 as build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm i
COPY . .
ARG TARGET_ENV='production'
RUN npm run build -- --configuration=$TARGET_ENV

# Stage 2: Serve the built app with a lightweight HTTP server
FROM nginx:alpine
COPY --from=build /app/dist/fuse /usr/share/nginx/html
# Custom NGINX configuration
# COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# Run this command
# docker build --build-arg TARGET_ENV=production -t fuse .
# docker run --rm -p 80:80 fuse

