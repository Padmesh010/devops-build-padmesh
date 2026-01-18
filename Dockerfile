FROM nginx:alpine

# Removing default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copying the React build files
COPY build/ /usr/share/nginx/html/

# Exposing HTTP port
EXPOSE 80

# Starting nginx
CMD ["nginx", "-g", "daemon off;"]
