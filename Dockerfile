FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Copy and install requirements
COPY requirements.txt /app/
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy project code
COPY . /app/

# Install Nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Expose port 80 (for Nginx)
EXPOSE 80

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/sites-available/default

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Command to run both Django and Nginx
CMD ["/start.sh"]
