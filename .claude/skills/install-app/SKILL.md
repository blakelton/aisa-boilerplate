---
name: install-app
description: Plan and install new applications on the system
---

# Application Installation

I'll help plan and install the requested application.

## Installation Process

### Phase 1: Planning
1. **Research** - Determine best installation method
2. **Requirements** - Check system requirements
3. **Conflicts** - Review system-inventory.json for port/resource conflicts
4. **Dependencies** - Identify required packages/services
5. **Security** - Review security implications

### Phase 2: Preparation
1. Update package lists
2. Install dependencies
3. Create required users/groups
4. Prepare directories
5. Configure firewall (if needed)

### Phase 3: Installation
1. Install application
2. Configure basic settings
3. Set up as service (if applicable)
4. Enable auto-start

### Phase 4: Verification
1. Start service
2. Verify functionality
3. Test access
4. Check logs

### Phase 5: Documentation
1. Generate management scripts in `servers/`
2. Update system-inventory.json
3. Log to system-changes.log

## Installation Methods

| Method | When to Use |
|--------|-------------|
| apt/yum | Standard packages |
| Docker | Isolated, reproducible |
| Docker Compose | Multi-container apps |
| Manual | Custom/source builds |
| Snap | Sandboxed apps |

## Pre-Installation Checklist

- [ ] Disk space sufficient
- [ ] Memory requirements met
- [ ] Required ports available
- [ ] Dependencies satisfied
- [ ] Backup plan ready
- [ ] User approved installation

Let me plan the installation...
