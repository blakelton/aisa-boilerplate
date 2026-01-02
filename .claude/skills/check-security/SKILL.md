---
name: check-security
description: Security audit - SSL certificates, updates, vulnerabilities, firewall
---

# Security Audit

I'll perform a comprehensive security audit of the system.

## Audit Areas

### 1. SSL/TLS Certificates
- Certificate expiration dates
- Certificate validity
- Weak cipher detection
- Certificate chain issues

### 2. System Updates
- Pending security updates
- Kernel updates
- Package vulnerabilities

### 3. Firewall Status
- UFW/iptables/nftables rules
- Open ports
- Unexpected listeners

### 4. Authentication Security
- Failed login attempts
- SSH configuration
- sudo access
- Password policies

### 5. Fail2ban (if installed)
- Active jails
- Banned IPs
- Recent bans

### 6. File Permissions
- World-writable files
- SUID/SGID binaries
- Sensitive file permissions

### 7. Running Services
- Unnecessary services
- Services running as root
- Outdated software

## Commands

```bash
# SSL certificate expiration
for cert in /etc/letsencrypt/live/*/cert.pem; do
    echo "$(dirname $cert): $(openssl x509 -enddate -noout -in $cert)"
done

# Pending updates
apt list --upgradable 2>/dev/null
yum check-update 2>/dev/null

# Firewall
ufw status verbose
iptables -L -n

# Open ports
ss -tuln

# Failed logins
grep "Failed password" /var/log/auth.log | tail -20

# Fail2ban
fail2ban-client status

# SSH config check
grep -E "^(PermitRootLogin|PasswordAuthentication|PubkeyAuthentication)" /etc/ssh/sshd_config
```

## Security Recommendations

After the audit, I'll provide:
- Critical issues requiring immediate attention
- Recommended improvements
- Best practice suggestions
- Action items prioritized by risk

Let me begin the security audit...
