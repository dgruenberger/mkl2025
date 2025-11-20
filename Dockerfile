# Base image with Node.js 20 on Debian slim for a small footprint
FROM node:20-slim

# Image metadata to indicate who maintains it
LABEL maintainer="it241515@ustp.at"

# Disable interactive prompts during apt commands
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and upgrade existing packages for security fixes
RUN apt update && apt upgrade -y

# Set the working directory inside the container
WORKDIR /usr/src/app

# Install the latest npm CLI and TypeORM globally for the build process
RUN npm i -g npm@11 typeorm

# Copy dependency manifests first to leverage Docker layer caching
COPY package*.json ./

# Install project dependencies based on the lockfile
RUN npm ci

# Copy the rest of the application source code
COPY . .

# Build the project (typically compiles TypeScript to JavaScript)
RUN npm run build