# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Rails 8.0.3 API application with a separate Next.js frontend, using:
- **Backend**: Rails 8 API with MySQL 8.0.43 (Trilogy adapter)
- **Frontend**: Next.js 15 with TypeScript and React Native Web (in `type_labo/` directory)
- **Authentication**: Devise + Devise-JWT for token-based authentication
- **Database Management**: Ridgepole for schema management
- **API Documentation**: Rswag for OpenAPI/Swagger documentation
- **Testing**: RSpec with FactoryBot, Faker, and Shoulda Matchers

## Development Environment

### Using Docker Compose

The project uses Docker Compose for local development with three services:

```bash
# Start all services (backend, frontend, database)
docker compose up

# Start specific service
docker compose up web      # Rails backend on port 3000
docker compose up type_labo # Next.js frontend on port 3001
docker compose up db       # MySQL database

# Run commands in containers
docker compose run --rm web bundle install
docker compose run --rm web bundle exec rails console
```

### Running Tests

```bash
# Run all RSpec tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/account_spec.rb

# Run specific test by line number
bundle exec rspec spec/models/account_spec.rb:10

# Generate OpenAPI documentation from specs
bundle exec rake rswag:specs:swaggerize
```

### Database Management

This project uses **Ridgepole** instead of standard Rails migrations. Schema is defined in `db/Schemafile`.

```bash
# Apply schema changes
docker compose run --rm web bundle exec ridgepole -c config/database.yml -s primary -a -f db/Schemafile

# Check connection in Rails console
ActiveRecord::Base.connection_pool.with_connection { it.active? }
```

### Code Quality

```bash
# Run RuboCop linter
bundle exec rubocop

# Auto-correct RuboCop violations
bundle exec rubocop -a

# Run security scanner
bundle exec brakeman
```

## Architecture

### Backend Structure

- **API Versioning**: Routes are namespaced under `/api/v1` with route definitions in `config/routes/api_v1.rb`
- **Authentication**: JWT-based authentication using Devise with `Account` model and `JwtDenylist` for token revocation
- **Database**: MySQL with primary/replica configuration support (configured via `MYSQL_READONLY_HOST` env vars)
- **API Documentation**: Swagger UI available at `/api-docs` endpoint

### Frontend Structure (`type_labo/`)

The frontend is a separate Next.js application with React Native Web integration:

```bash
# Development server (inside type_labo/)
npm run dev    # Runs on port 3001 with Turbopack

# Build
npm run build

# Lint
npm run lint
```

### Models

- **Account**: Devise-enabled user model with full authentication features (confirmable, lockable, recoverable, trackable)
- **JwtDenylist**: Stores invalidated JWT tokens with expiration times

### Database Configuration

The application uses a multi-database setup with primary and primary_replica connections. Environment variables:
- `MYSQL_HOST`: Primary database host
- `MYSQL_READONLY_HOST`: Read replica host (falls back to primary if not set)
- `MYSQL_USERNAME`, `MYSQL_PASSWORD`, `MYSQL_PORT`: Connection credentials

## Key Dependencies

### Backend
- `ridgepole`: Schema management (alternative to migrations)
- `devise` + `devise-jwt`: Authentication
- `rswag-api`, `rswag-ui`, `rswag-specs`: OpenAPI documentation
- `pry-rails`, `pry-byebug`: Debugging tools
- `solid_cache`, `solid_queue`, `solid_cable`: Rails 8 solid components

### Frontend
- `next`: 15.5.2 with Turbopack
- `react-native-web`: Cross-platform component support
- `zod`: Schema validation
- `tailwindcss`: Styling (v4)

## Common Patterns

### Adding API Endpoints

1. Add route in `config/routes/api_v1.rb` under `namespace :api do namespace :v1`
2. Create controller in `app/controllers/api/v1/`
3. Add RSpec request spec in `spec/requests/api/v1/` with Rswag documentation
4. Run `bundle exec rake rswag:specs:swaggerize` to update OpenAPI docs

### Schema Changes

1. Edit `db/Schemafile` (not migrations)
2. Run Ridgepole command to apply changes
3. Update models and specs accordingly

### Authentication

The API uses JWT tokens via Devise. Controllers requiring authentication should inherit authentication logic from Devise. The `JwtDenylist` model tracks revoked tokens.
