# Railway Deployment Documentation

## Official Railway Documentation
- [Railway Documentation Home](https://docs.railway.app/)
- [Getting Started Guide](https://docs.railway.app/getting-started)
- [Deploy Guide](https://docs.railway.app/deploy/deployments)
- [Database Guide](https://docs.railway.app/databases/postgresql)

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

## Current Project Configuration

### Environment Variables Required
```env
APP_KEY=base64:xxx
JWT_SECRET=xxx
APP_ENV=production
APP_DEBUG=false
LOG_CHANNEL=stderr
QUEUE_CONNECTION=sync
MAIL_MAILER=log
FILESYSTEM_PUBLIC_DISK=public
FILESYSTEM_PRIVATE_DISK=local
APP_CDN_URL=${RAILWAY_PUBLIC_DOMAIN}/storage
APP_FRONTEND_URL=${RAILWAY_PUBLIC_DOMAIN}
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
