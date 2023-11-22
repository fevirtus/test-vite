# Use a Node.js image for building the application
FROM node:20-alpine as builder

WORKDIR /app
COPY package*.json ./
RUN yarn install
COPY . .
RUN yarn run build

# ---

FROM nginx:1.13-alpine

WORKDIR /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html
COPY deploy/nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

