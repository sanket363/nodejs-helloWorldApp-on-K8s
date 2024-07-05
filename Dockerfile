# Stage 1: Build
FROM node:14 AS build

# Creating workdir inside the container
WORKDIR /app

# Copy package.json & package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm -g install

# Copy the rest of the application code
COPY . .

# Stage 2: Run
FROM node:14-alpine

WORKDIR /app

# Copy built application from the build stage
COPY --from=build /app .

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]

