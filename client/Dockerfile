# Use Node 18 Alpine image for React frontend
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Set environment variables
ENV NODE_ENV=production
ENV CI=true

# Install dependencies for node-gyp
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    git

# Copy package files
COPY client/package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY client/ .

# Build the application
RUN npm run build

# Install serve to run the application
RUN npm install -g serve

# Create non-root user
RUN addgroup -g 1001 -S nodejs \
    && adduser -S nextjs -u 1001

# Change ownership of the app directory
RUN chown -R nextjs:nodejs /app
USER nextjs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:3000/ || exit 1

# Serve the built application
CMD ["serve", "-s", "dist", "-l", "3000"]
