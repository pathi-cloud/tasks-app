#################################
# Build stage
#################################
FROM docker.io/node:18-slim AS builder

WORKDIR /home/dev/ws

COPY package*.json ./

RUN npm ci --audit=false --fund=false

COPY src/ ./src/
COPY tsconfig.json \
     tsconfig.app.json \
     tsconfig.node.json \
     index.html \
     vite.config.ts \
     public \
     ./

RUN npm run build

# Serve with Nginx
FROM nginx:alpine AS tasks-app

# Copy the built files to Nginx's serving directory
COPY --from=builder /home/dev/ws/dist /usr/share/nginx/html

# Copy a custom Nginx config (optional)
COPY nginx.conf /etc/nginx/conf.d/default.conf
