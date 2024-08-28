FROM node:alpine3.18 as build

# Declare build time environment variables
# ARG REACT_APP_NODE_ENV
# ARG BACKEND_HOST

# Set default values for environment variables
# ENV REACT_APP_NODE_ENV=$REACT_APP_NODE_ENV
# ENV BACKEND_HOST=$BACKEND_HOST

# Build App
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Serve with Nginx
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .
COPY ./default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]