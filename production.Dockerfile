# Start a new stage for the final image
FROM ruby:3.3.1-alpine

# Set environment variables
ENV RAILS_ENV=production \
    NODE_ENV=production \
    LANG=C.UTF-8 \
    RAILS_SERVE_STATIC_FILES=true

# Install runtime dependencies
RUN apk update && \
    apk add --no-cache build-base postgresql-dev tzdata nodejs && \
    npm install -g npm@latest

# Set up the working directory
WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /app /app

# Expose the Rails port
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
