#!/bin/sh

set -e
echo "Starting application setup..."

cd /app/backend
echo "Changed directory to /app/backend"

echo "Checking environment variables..."
echo "APP_KEY: ${APP_KEY:0:10}..."

# Configure database connection
if [ -n "$RAILWAY_POSTGRESQL_CONNECTION_URL" ]; then
    echo "Using Railway PostgreSQL URL"
    export DATABASE_URL="$RAILWAY_POSTGRESQL_CONNECTION_URL"
elif [ -n "$DATABASE_URL" ]; then
    echo "Using provided DATABASE_URL"
else
    echo "ERROR: No database connection URL found"
    exit 1
fi

# Configure frontend URLs
if [ -n "$RAILWAY_PUBLIC_DOMAIN" ]; then
    echo "Setting up frontend URLs with RAILWAY_PUBLIC_DOMAIN"
    export VITE_FRONTEND_URL="https://$RAILWAY_PUBLIC_DOMAIN"
    export VITE_API_URL_CLIENT="https://$RAILWAY_PUBLIC_DOMAIN/api"
    export APP_FRONTEND_URL="https://$RAILWAY_PUBLIC_DOMAIN"
    export APP_CDN_URL="https://$RAILWAY_PUBLIC_DOMAIN/storage"
fi

echo "Database configuration:"
echo "Host: $(echo $DATABASE_URL | sed -E 's/.*@([^:]+).*/\1/')"

# Test database connection
echo "Testing database connection..."
if ! php artisan tinker --execute="try { DB::connection()->getPdo(); echo 'Connected successfully!'; } catch (\Exception \$e) { echo 'Connection failed: ' . \$e->getMessage(); exit(1); }"; then
    echo "============================================"
    echo "ERROR: Database connection test failed"
    echo "============================================"
    exit 1
fi

echo "Running database migrations..."
if ! php artisan migrate --force; then
    echo "============================================"
    echo "ERROR: Migrations could not complete. Check the error above."
    echo "Database URL format should be: postgresql://user:password@host:5432/dbname"
    echo "============================================"
    exit 1
fi

echo "Clearing caches..."
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

echo "Creating storage link..."
rm -f public/storage
php artisan storage:link

echo "Setting permissions..."
chown -R www-data:www-data /app/backend
chmod -R 775 /app/backend/storage /app/backend/bootstrap/cache

echo "Starting supervisord..."
exec /usr/bin/supervisord -c /etc/supervisord.conf
