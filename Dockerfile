FROM node:lts-alpine as build
WORKDIR /app
COPY package*.json ./
COPY . .
RUN yarn install && \
    yarn build && \
    rm dist/vite.svg

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
