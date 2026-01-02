---
name: monitor-system
description: Monitor overall system health, resources, and services
---

# System Health Monitor

I'll perform a comprehensive system health check across all resources and services.

## Monitoring Checklist

1. **Hardware Resources**
   - CPU usage and load averages
   - Memory usage (RAM and swap)
   - Disk space and I/O
   - Temperature sensors (if available)
   - GPU status (if available)

2. **Services Status**
   - All critical services from system-inventory.json
   - Docker/Podman containers
   - LXD containers

3. **Network Health**
   - Interface status
   - Active connections
   - Listening ports

4. **Security**
   - Fail2ban status (if installed)
   - SSL certificate expiration dates
   - UPS status (if available)

5. **Logs**
   - Recent errors in system logs
   - Service-specific errors

## Commands Used

```bash
# System load and uptime
uptime

# CPU usage
top -bn1 | head -5

# Memory
free -h

# Disk
df -h

# Services
systemctl list-units --type=service --state=running

# Docker containers
docker ps

# Recent errors
journalctl -p err --since "1 hour ago" --no-pager | tail -20
```

Let me start the monitoring scan...
