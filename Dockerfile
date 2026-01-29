# Stage 1: Build

FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY . .

 

# Stage 2: Run

FROM node:18-alpine

WORKDIR /app

 

# Create non-root user and group

RUN addgroup -S nodejs && adduser -S nodejs -G nodejs

 

# Copy files from builder and set ownership

COPY --from=builder /app /app

RUN chown -R nodejs:nodejs /app

 

# Switch to non-root user

USER nodejs

 

EXPOSE 3000

CMD ["npm", "start"]
