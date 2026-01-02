# System Discovery Agent

This document describes the system discovery workflow for the `/familiarize` command.

## Agent Purpose

The system discovery agent performs comprehensive analysis of a Linux system to:
1. Document all hardware and software
2. Identify running services and their configurations
3. Map network topology
4. Generate management scripts
5. Create the system inventory JSON

## Discovery Workflow

### Step 1: Hardware Discovery

```bash
# CPU Information
lscpu | grep -E "^(Model name|Architecture|CPU\(s\)|Thread|Core|Socket)"

# Memory
free -h
cat /proc/meminfo | head -5

# Storage Devices
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,FSTYPE
df -h

# GPU Detection
if command -v nvidia-smi &>/dev/null; then
    nvidia-smi --query-gpu=name,memory.total,driver_version --format=csv,noheader
else
    lspci | grep -i 'vga\|3d\|display'
fi

# Hardware sensors (if available)
sensors 2>/dev/null || echo "No sensors detected"

# UPS (if available)
upsc 2>/dev/null || echo "No UPS detected"
```

### Step 2: Operating System

```bash
# OS Information
cat /etc/os-release
uname -a
hostnamectl

# Uptime and load
uptime
```

### Step 3: Network Discovery

```bash
# Interfaces
ip -br addr show
ip route show

# DNS
cat /etc/resolv.conf

# Listening ports
ss -tuln | sort -k5

# Firewall status
sudo ufw status 2>/dev/null || sudo iptables -L -n 2>/dev/null | head -20
```

### Step 4: Service Discovery

```bash
# All running services
systemctl list-units --type=service --state=running --no-pager

# Key service categories to check:
SERVICES=(
    # Web servers
    "nginx" "apache2" "httpd" "caddy" "traefik"
    # Databases
    "postgresql" "mysql" "mariadb" "mongodb" "redis" "memcached"
    # Containers
    "docker" "containerd" "podman" "lxd"
    # Mail
    "postfix" "dovecot" "exim4"
    # Security
    "fail2ban" "ufw" "firewalld"
    # Monitoring
    "prometheus" "grafana" "node_exporter" "zabbix-agent"
    # CI/CD
    "jenkins" "gitlab-runner" "drone"
    # AI/ML
    "ollama"
    # Other common
    "sshd" "cron" "cups" "samba" "nfs-server" "nut-server"
)

for svc in "${SERVICES[@]}"; do
    systemctl is-active "$svc" 2>/dev/null && echo "FOUND: $svc"
done
```

### Step 5: Container Discovery

```bash
# Docker
if command -v docker &>/dev/null && docker info &>/dev/null; then
    echo "=== Docker Containers ==="
    docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

    echo "=== Docker Networks ==="
    docker network ls

    echo "=== Docker Volumes ==="
    docker volume ls
fi

# Podman
if command -v podman &>/dev/null; then
    echo "=== Podman Containers ==="
    podman ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
fi

# LXD/LXC
if command -v lxc &>/dev/null; then
    echo "=== LXD Containers ==="
    lxc list
fi
```

### Step 6: Web Server Analysis

```bash
# Nginx
if systemctl is-active nginx &>/dev/null; then
    echo "=== Nginx Sites ==="
    ls -la /etc/nginx/sites-enabled/
    nginx -T 2>/dev/null | grep -E "server_name|listen|proxy_pass" | head -50
fi

# Apache
if systemctl is-active apache2 &>/dev/null || systemctl is-active httpd &>/dev/null; then
    echo "=== Apache Sites ==="
    ls -la /etc/apache2/sites-enabled/ 2>/dev/null || ls -la /etc/httpd/conf.d/
fi

# SSL Certificates
if [ -d /etc/letsencrypt/live ]; then
    echo "=== SSL Certificates ==="
    for domain in /etc/letsencrypt/live/*/; do
        domain_name=$(basename "$domain")
        expiry=$(openssl x509 -enddate -noout -in "$domain/cert.pem" 2>/dev/null | cut -d= -f2)
        echo "$domain_name: expires $expiry"
    done
fi
```

### Step 7: Database Discovery

```bash
# PostgreSQL
if systemctl is-active postgresql* &>/dev/null; then
    echo "=== PostgreSQL ==="
    sudo -u postgres psql -c "\l" 2>/dev/null || echo "PostgreSQL running (cannot list DBs)"
fi

# MySQL/MariaDB
if systemctl is-active mysql &>/dev/null || systemctl is-active mariadb &>/dev/null; then
    echo "=== MySQL/MariaDB ==="
    mysql -e "SHOW DATABASES;" 2>/dev/null || echo "MySQL running (cannot list DBs)"
fi

# Redis
if systemctl is-active redis* &>/dev/null; then
    echo "=== Redis ==="
    redis-cli INFO server 2>/dev/null | head -10 || echo "Redis running"
fi
```

## Output Generation

### System Inventory JSON Structure

```json
{
  "metadata": {
    "generated_at": "YYYY-MM-DD HH:MM:SS",
    "hostname": "hostname",
    "generated_by": "AISA System Discovery",
    "version": "1.0"
  },
  "hardware": {
    "cpu": {},
    "memory": {},
    "storage": {},
    "gpu": {},
    "network_interfaces": []
  },
  "operating_system": {},
  "network": {
    "primary_ip": "",
    "interfaces": [],
    "routing": [],
    "listening_ports": []
  },
  "services": {
    "web_servers": {},
    "databases": {},
    "containers": {},
    "mail": {},
    "security": {},
    "monitoring": {},
    "other": {}
  },
  "containerization": {
    "docker": {},
    "podman": {},
    "lxd": {}
  },
  "websites": [],
  "security": {
    "ssl_certificates": {},
    "firewall": {},
    "fail2ban": {}
  },
  "management_scripts": {}
}
```

### Management Script Generation

For each discovered service, generate:

1. **Health Check Script** (`servers/<service>/check-<service>.sh`)
   - Service status check
   - Port/API availability
   - Resource usage
   - Recent errors in logs

2. **Management Script** (`servers/<service>/<service>.sh`)
   - start/stop/restart commands
   - Status display
   - Log viewing
   - Update procedures (if applicable)

3. **README** (`servers/<service>/README.md`)
   - Service description
   - Configuration locations
   - Common operations
   - Troubleshooting tips

## Script Templates

See `templates/` directory for:
- `check-service.sh.template` - Health check template
- `manage-service.sh.template` - Management script template
- `docker-service.sh.template` - Docker container management template
- `README.md.template` - Service documentation template
