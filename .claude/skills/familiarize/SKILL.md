---
name: familiarize
description: Scan and document the entire system, creating inventory, management scripts, and configuration
---

# System Familiarization

I'll perform a comprehensive scan of this system to discover and document all hardware, services, containers, and configurations. This creates the foundation for AI-assisted system administration.

## Process Overview

This familiarization will:
1. **Hardware Discovery** - CPU, memory, storage, GPU, network interfaces
2. **OS Information** - Distribution, version, kernel
3. **Service Discovery** - All running systemd services, their purposes and ports
4. **Container Discovery** - Docker, Podman, LXD containers and their configurations
5. **Web Server Analysis** - Nginx/Apache sites, SSL certificates, reverse proxies
6. **Database Discovery** - PostgreSQL, MySQL, Redis, MongoDB instances
7. **Security Audit** - Firewall status, fail2ban, SSL expiration
8. **Network Topology** - Interfaces, bridges, routes, listening ports
9. **Generate Management Scripts** - Create check/status scripts for each service
10. **Create System Inventory** - Comprehensive JSON documentation

## Execution Plan

### Phase 1: Hardware & OS Discovery
```bash
# CPU
lscpu

# Memory
free -h

# Storage
lsblk
df -h

# GPU (if present)
nvidia-smi 2>/dev/null || lspci | grep -i vga

# Network interfaces
ip -br addr show
ip route show
```

### Phase 2: Service Discovery
```bash
# All running services
systemctl list-units --type=service --state=running

# Listening ports
ss -tuln

# Key services to check
systemctl status nginx apache2 postgresql mysql redis docker containerd
```

### Phase 3: Container Discovery
```bash
# Docker
docker ps -a
docker network ls
docker images

# Podman (if present)
podman ps -a 2>/dev/null

# LXD/LXC (if present)
lxc list 2>/dev/null
```

### Phase 4: Web Server Analysis
```bash
# Nginx sites
ls -la /etc/nginx/sites-enabled/

# Apache sites
ls -la /etc/apache2/sites-enabled/ 2>/dev/null

# SSL certificates
ls -la /etc/letsencrypt/live/ 2>/dev/null
```

### Phase 5: Generate Artifacts

For each discovered service, I will:
1. Create a management script in `servers/<service>/`
2. Create a health check script
3. Document in system-inventory.json
4. Add to the quick reference

## Output Files

After completion, you will have:

- `system-inventory.json` - Complete system documentation
- `servers/` - Directory with management scripts for each service
- `.claude/system-changes.log` - Initial entry documenting the scan
- Updated `.claude_instructions` - With system-specific details

## Options

- `--quick` - Skip detailed analysis, just get basic inventory

Let me begin the system familiarization...

## Important Notes

- This process is READ-ONLY - no system changes will be made
- All findings are documented in the change log
- Review the generated inventory for accuracy
- Run `/update-inventory` anytime to refresh

Starting comprehensive system scan now...
