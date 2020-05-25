#FROM nginx
FROM nginx:alpine

## Step 1:
#RUN rm /usr/share/nginx/html/index.html
# Create a working directory
WORKDIR /app
# Copy source code to working directory
COPY index.html /usr/share/nginx/html /app/

#COPY default.conf /etc/nginx/conf.d/default.conf
#COPY index.html /usr/share/nginx/html/index.html
