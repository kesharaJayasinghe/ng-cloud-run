FROM node:16-alpine3.18 as build
WORKDIR /app
COPY  ./package*.json .

RUN npm ci

COPY . .
RUN npm run build

FROM nginx:1.23.0-alpine
EXPOSE 8080
COPY nginx.conf  /etc/nginx/nginx.conf
COPY --from=build /app/dist/ng-cloud-run /usr/share/nginx/html