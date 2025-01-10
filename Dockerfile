FROM node:20-alpine

# Add a non-root user
RUN addgroup app && adduser -S -G app app

# Set the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./

# Temporarily use root to change permissions
USER root
RUN npm install && chown -R app:app /app

# Copy the application code and ensure proper permissions
COPY . .
RUN chown -R app:app /app

# Switch back to the non-root user
USER app

EXPOSE 3000
CMD ["npm", "run", "dev"]
