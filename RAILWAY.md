# Railway Deployment Documentation

## Official Railway Documentation
- [Railway Documentation Home](https://docs.railway.app/)
- [Getting Started Guide](https://docs.railway.app/getting-started)
- [Deploy Guide](https://docs.railway.app/deploy/deployments)
- [Database Guide](https://docs.railway.app/databases/postgresql)

## Hi.Events Documentation
- [Hi.Events Documentation Home](https://hi.events/docs)
- [Getting Started Guide](https://hi.events/docs/getting-started)
- [Deployment Guide](https://hi.events/docs/getting-started/deploying)
- [Local Development](https://hi.events/docs/getting-started/local-development)
- [Environment Configuration](https://hi.events/docs/getting-started/environment-configuration)
- [Database Setup](https://hi.events/docs/getting-started/database-setup)

## Key Configuration References

### Railway.toml Configuration
- [Railway.toml Reference](https://docs.railway.app/deploy/railway-toml)
- [Build Settings](https://docs.railway.app/deploy/builds)
- [Deployments](https://docs.railway.app/deploy/deployments)
- [Exposing Your App](https://docs.railway.app/deploy/exposing-your-app)

### Database Configuration
- [PostgreSQL Setup](https://docs.railway.app/databases/postgresql)
- [Database Migrations](https://docs.railway.app/databases/migrations)
- [Connecting to Your Database](https://docs.railway.app/databases/connecting)
- [Database Backups](https://docs.railway.app/databases/backups)

### Environment Variables
- [Environment Variables Guide](https://docs.railway.app/develop/variables)
- [Shared Variables](https://docs.railway.app/develop/variables#shared-variables)
- [Reference Variables](https://docs.railway.app/develop/variables#reference-variables)

### Monitoring and Debugging
- [Viewing Logs](https://docs.railway.app/deploy/logs)
- [Metrics](https://docs.railway.app/reference/metrics)
- [Health Checks](https://docs.railway.app/deploy/healthchecks)
- [Troubleshooting Deployments](https://docs.railway.app/deploy/troubleshooting)

### Docker Support
- [Docker Deployments](https://docs.railway.app/deploy/docker)
- [Dockerfile Configuration](https://docs.railway.app/deploy/docker#dockerfile)
- [Docker Compose](https://docs.railway.app/deploy/docker#docker-compose)

### Custom Domains
- [Custom Domains Guide](https://docs.railway.app/deploy/exposing-your-app#custom-domains)
- [SSL/TLS Configuration](https://docs.railway.app/deploy/exposing-your-app#ssl-certificates)

### CLI Usage
- [Railway CLI Installation](https://docs.railway.app/develop/cli)
- [CLI Commands Reference](https://docs.railway.app/develop/cli#commands)
- [Local Development](https://docs.railway.app/develop/local-development)

### Best Practices
- [Production Checklist](https://docs.railway.app/reference/production-checklist)
- [Security Best Practices](https://docs.railway.app/reference/security)
- [Resource Management](https://docs.railway.app/reference/resource-management)

## Environment Variables Configuration

### Frontend Variables
```env
VITE_FRONTEND_URL=${RAILWAY_PUBLIC_DOMAIN}
VITE_API_URL_CLIENT=${RAILWAY_PUBLIC_DOMAIN}/api
VITE_API_URL_SERVER=http://localhost:80/api
VITE_STRIPE_PUBLISHABLE_KEY=pk_test_51...
```

### Backend Core Variables
```env
# Application Settings
APP_KEY=base64:xxx                 # Generate with: echo "base64:$(openssl rand -base64 32)"
APP_ENV=production
APP_DEBUG=false
APP_FRONTEND_URL=${RAILWAY_PUBLIC_DOMAIN}
APP_CDN_URL=${RAILWAY_PUBLIC_DOMAIN}/storage
APP_SAAS_MODE_ENABLED=true        # Set to false for non-SaaS deployments
APP_SAAS_STRIPE_APPLICATION_FEE_PERCENT=1.5
APP_DISABLE_REGISTRATION=false    # Set to true to disable new account registration

# JWT Authentication
JWT_SECRET=xxx                    # Generate with: echo "base64:$(openssl rand -base64 32)"

# Logging and Queue
LOG_CHANNEL=stderr
QUEUE_CONNECTION=redis            # Use 'sync' for development, 'redis' for production
```

### Mail Configuration
```env
MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=your-username
MAIL_PASSWORD=your-password
MAIL_FROM_ADDRESS=noreply@yourdomain.com
MAIL_FROM_NAME="Hi.Events"
```

### Stripe Configuration
```env
STRIPE_PUBLIC_KEY=pk_test_51...
STRIPE_SECRET_KEY=sk_test_51...
STRIPE_WEBHOOK_SECRET=whsec_...    # Set webhook URL to: ${RAILWAY_PUBLIC_DOMAIN}/api/public/webhooks/stripe
```

### File Storage Configuration
```env
# Local Storage (Development)
FILESYSTEM_PUBLIC_DISK=public
FILESYSTEM_PRIVATE_DISK=local

# S3 Storage (Recommended for Production)
AWS_ACCESS_KEY_ID=your-access-key
AWS_SECRET_ACCESS_KEY=your-secret-key
AWS_DEFAULT_REGION=us-west-1
AWS_PUBLIC_BUCKET=your-public-bucket
AWS_PRIVATE_BUCKET=your-private-bucket
FILESYSTEM_PUBLIC_DISK=s3-public   # Use this when AWS is configured
FILESYSTEM_PRIVATE_DISK=s3-private # Use this when AWS is configured
```

### Database Configuration
```env
# Option 1: Using DATABASE_URL (Recommended for Railway)
DATABASE_URL=${RAILWAY_POSTGRESQL_CONNECTION_URL}

# Option 2: Individual Settings
DB_CONNECTION=pgsql
DB_HOST=postgres.railway.internal
DB_PORT=5432
DB_DATABASE=railway
DB_USERNAME=postgres
DB_PASSWORD=your-password
```

### Redis Configuration (Recommended for Production)
```env
# Option 1: Using REDIS_URL (Recommended for Railway)
REDIS_URL=${RAILWAY_REDIS_CONNECTION_URL}

# Option 2: Individual Settings
REDIS_HOST=your-redis-host
REDIS_PASSWORD=your-redis-password
REDIS_USER=your-redis-username
REDIS_PORT=6379
```

### Railway-Specific Variables
These are automatically provided by Railway:
```env
RAILWAY_PUBLIC_DOMAIN
RAILWAY_PRIVATE_DOMAIN
RAILWAY_POSTGRESQL_CONNECTION_URL
RAILWAY_REDIS_CONNECTION_URL
```

## Important Notes

1. **Production Setup**
   - Use Redis for queue connection
   - Configure S3 or similar cloud storage
   - Set up proper mail configuration
   - Configure Stripe webhooks

2. **Security**
   - Never commit sensitive credentials to version control
   - Use Railway's variable management system
   - Regularly rotate secrets and keys

3. **File Storage**
   - Local storage is not recommended for production
   - Use S3 or similar cloud storage to prevent data loss

4. **Queue System**
   - Use Redis for production deployments
   - `sync` driver is only suitable for development

## Current Project Configuration

### Environment Variables Required (Based on Hi.Events Documentation)
```env
# Core Application Settings
APP_KEY=base64:xxx
JWT_SECRET=xxx
APP_ENV=production
APP_DEBUG=false

# Logging and Queue
LOG_CHANNEL=stderr
QUEUE_CONNECTION=sync
MAIL_MAILER=log

# File Storage
FILESYSTEM_PUBLIC_DISK=public
FILESYSTEM_PRIVATE_DISK=local
APP_CDN_URL=${RAILWAY_PUBLIC_DOMAIN}/storage
APP_FRONTEND_URL=${RAILWAY_PUBLIC_DOMAIN}

# Database (Railway PostgreSQL)
DATABASE_URL=postgresql://postgres:password@postgres.railway.internal:5432/railway

# Additional Hi.Events Settings
VITE_API_URL_CLIENT=${RAILWAY_PUBLIC_DOMAIN}/api
VITE_API_URL_SERVER=http://localhost:80/api
VITE_FRONTEND_URL=${RAILWAY_PUBLIC_DOMAIN}
VITE_STRIPE_PUBLISHABLE_KEY=your_stripe_key
```

### Health Check Configuration
- Path: `/api/health`
- Timeout: 300 seconds
- Restart Policy: On Failure
- Max Retries: 3

### Port Configuration
- Application Port: 80
- Database Port: 5432

### Database Connection
- Internal URL: postgres.railway.internal
- Connection String Format: `postgresql://postgres:password@postgres.railway.internal:5432/railway`
