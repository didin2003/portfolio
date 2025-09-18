#!/bin/bash

# Apply migrations
python3 manage.py migrate

# Collect static files
python3 manage.py collectstatic --noinput

# Start Django in the background
gunicorn myportfolio.wsgi:application \
  --bind 0.0.0.0:8000 \
  --workers 3 \
  --timeout 120 &
# Start Nginx in the foreground
nginx -g "daemon off;"
