#build satge
FROM node:lts-alpine as build-satge
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

from nginx:stable-alpine as production-satge
copy --from=build-satge /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g","daemon off;"]
