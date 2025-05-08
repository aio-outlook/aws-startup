

chmod +x /opt/scripts/update_fallback_images.sh


sudo yum install cronie -y     # For Amazon Linux/Fedora
sudo systemctl start crond
sudo systemctl enable crond

crontab -e


0 2 * * * /opt/scripts/update_fallback_images.sh >> /var/log/fallback_update.log 2>&1
