---
name: check-logs
description: Analyze system and service logs for errors and warnings
---

# Log Analysis

I'll analyze logs for errors, warnings, and patterns that indicate issues.

## Log Sources

### System Logs
- `/var/log/syslog` or `/var/log/messages`
- `journalctl` (systemd journal)
- `/var/log/dmesg` (kernel messages)
- `/var/log/auth.log` (authentication)

### Service Logs
- `journalctl -u <service>`
- Service-specific log files
- Docker container logs

### Application Logs
- `/var/log/<application>/`
- Custom log locations

## Analysis Process

1. **Identify Time Range**
   - When did the issue start?
   - Correlate with recent changes

2. **Filter by Severity**
   - Critical/Emergency
   - Errors
   - Warnings

3. **Pattern Recognition**
   - Repeated errors
   - Error bursts
   - Correlating events

4. **Context Gathering**
   - Events before/after errors
   - Related service logs

## Commands

```bash
# Recent system errors
journalctl -p err --since "1 hour ago" --no-pager

# Specific service
journalctl -u <service> -p warning --since "24 hours ago"

# Authentication issues
grep -i "failed\|error" /var/log/auth.log | tail -50

# Nginx errors
tail -100 /var/log/nginx/error.log

# Docker container
docker logs --since 1h <container> 2>&1 | grep -i "error\|warn"
```

Let me analyze the logs...
