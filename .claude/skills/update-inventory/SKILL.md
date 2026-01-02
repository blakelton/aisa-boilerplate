---
name: update-inventory
description: Update the system inventory documentation with current system state
---

# Update System Inventory

I'll scan the system and update the system-inventory.json file with the current state.

## What Gets Updated

1. **Hardware** - Current memory/disk usage
2. **Services** - Running status, versions
3. **Containers** - Docker/Podman/LXD container status
4. **Network** - Active interfaces, listening ports
5. **Security** - SSL certificate expiration, fail2ban status

## Process

1. Read current system-inventory.json
2. Scan each section for changes
3. Update changed sections
4. Log changes to system-changes.log

## Options

- `--section <name>` - Only update specific section (hardware, services, containers, network, security)

Let me scan the system and update the inventory...
