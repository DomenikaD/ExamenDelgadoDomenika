FROM debian:latest

RUN apt-get update && apt-get install -y \
    apache2 \
    curl \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g @angular/cli

WORKDIR /app
COPY . /app
RUN npm install && ng build --configuration production

RUN rm -rf /var/www/html/* \
    && cp -r /app/dist/* /var/www/html/

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
