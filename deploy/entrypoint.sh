#!/usr/bin/env bash
set -e

# optional: load environment variables from .env if you have one
# [ -f /app/.env ] && export $(grep -v '^#' /app/.env | xargs)

# make sure python can run
# collect static files into /vol/static (nginx will serve from there)
echo "Collecting static files..."
python /app/manage.py collectstatic --noinput || echo "collectstatic failed (continuing)"

# optionally run migrations (uncomment if desired)
# echo "Applying migrations..."
# python /app/manage.py migrate --noinput || echo "migrate failed (continuing)"

# ensure nginx can read static files
chown -R www-data:www-data /vol/static || true
chmod -R a+rX /vol/static || true

# remove stale nginx pid files
rm -f /var/run/nginx.pid /run/nginx.pid || true

echo "Starting supervisord..."
exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
