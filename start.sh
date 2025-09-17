#!/bin/bash

# Apply migrations
python3 manage.py migrate

# Collect static files
python3 manage.py collectstatic --noinput

# Start Django in the background
python3 manage.py runserver 0.0.0.0:8000 &

# Start Nginx in the foreground
nginx -g "daemon off;"
