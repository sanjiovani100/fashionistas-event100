#!/bin/sh

set -e
echo "Starting application setup..."

cd /app/backend
echo "Changed directory to /app/backend"

echo "Checking environment variables..."
echo "APP_KEY: ${APP_KEY:0:10}..."
echo "DATABASE_URL exists: $(if [ -n "$DATABASE_URL" ]; then echo "yes"; else echo "no"; fi)"

echo "Running database migrations..."
if ! php artisan migrate --force; then
    echo "============================================"
    echo "ERROR: Migrations could not complete. Check the error above."
    echo "Ensure DATABASE_URL is set."
    echo "============================================"
    exit 1
fi

echo "Clearing caches..."
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

echo "Creating storage link..."
php artisan storage:link

echo "Setting permissions..."
chown -R www-data:www-data /app/backend
chmod -R 775 /app/backend/storage /app/backend/bootstrap/cache

echo "Starting supervisord..."
exec /usr/bin/supervisord -c /etc/supervisord.conf
