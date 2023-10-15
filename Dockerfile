FROM node:16-alpine3.16 as build
WORKDIR /usr/src/app
COPY package*.json ./

RUN npm install

COPY . .
RUN npm run build --prod

FROM nginx:latest

COPY --from=build /usr/src/app/dist/* /usr/share/nginx/html

EXPOSE 80
# Run the web service on container startup.
CMD ["nginx", "-g", "daemon off;"]