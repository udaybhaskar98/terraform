#!/bin/bash
set -e
sudo dnf install -y nginx
sudo systemctl enable --now nginx
echo "<h1>Welcome to Nginx From Terraform</h1>" > /usr/share/nginx/html/index.html