# Use the official Node.js image as the base image
FROM node:latest AS build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the entire project to the container
COPY . .

# Build the project (Adjust if necessary)
RUN npm run build

# Stage 2 - Production environment
FROM nginx:stable-alpine

# Copy the build files from the 'build' directory to the Nginx server's default public folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 (Adjust if necessary)
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
