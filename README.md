# AISA - AI System Administrator

A professional, system-agnostic framework for AI-assisted Linux system administration using Claude Code.

## Overview

AISA (AI System Administrator) provides a structured approach to managing Linux servers with AI assistance. It includes:

- **Automated System Discovery** - Scan and document your entire system
- **21 Slash Commands** - Common sysadmin tasks at your fingertips
- **Change Management** - Comprehensive logging of all changes
- **Service Management** - Auto-generated scripts for each service
- **Security Auditing** - Built-in security checks
- **Documentation** - Self-maintaining system inventory

## Quick Start

### Installation

```bash
# Clone or copy this repository
git clone git@github.com:blakelton/aisa-boilerplate.git ~/projects/aisa

# Run the installer
cd ~/projects/aisa
./install.sh ~/projects/aisa

# Or install to the default location
./install.sh
```

### First Run

1. Open the AISA directory in Claude Code
2. Run the familiarization command:
   ```
   /familiarize
   ```
3. This will scan your system and create:
   - Complete system inventory (`system-inventory.json`)
   - Management scripts for each discovered service (`servers/`)
   - Initial change log entry

## Available Commands

### System Setup
| Command | Description |
|---------|-------------|
| `/familiarize` | **Run first!** Scan and document entire system |
| `/update-inventory` | Refresh system documentation |

### Monitoring
| Command | Description |
|---------|-------------|
| `/monitor-system` | Overall system health check |
| `/monitor-service <name>` | Detailed service monitoring |
| `/monitor-resources` | CPU, memory, disk, network usage |
| `/monitor-hardware` | Temps, SMART, UPS, sensors |

### Troubleshooting
| Command | Description |
|---------|-------------|
| `/troubleshoot-system [issue]` | System-wide root cause analysis |
| `/troubleshoot-service <name>` | Service-specific debugging |
| `/check-logs [service]` | Analyze logs for errors |
| `/analyze-performance` | Find performance bottlenecks |

### Management
| Command | Description |
|---------|-------------|
| `/view-changelog [count]` | View recent changes |
| `/restart-service <name>` | Safe restart with validation |
| `/test-service <name>` | Health and functionality tests |
| `/create-server-scripts <name>` | Generate management scripts |

### Installation & Planning
| Command | Description |
|---------|-------------|
| `/install-app <name>` | Plan and install applications |
| `/plan-deployment <system>` | Architecture and deployment planning |
| `/plan-ai-service <type>` | AI/ML service deployment |

### Security & Optimization
| Command | Description |
|---------|-------------|
| `/check-security` | Security audit |
| `/optimize-service <name>` | Performance optimization |
| `/backup-config [target]` | Backup configurations |

### Reporting
| Command | Description |
|---------|-------------|
| `/generate-report [type]` | System status reports |

## Project Structure

```
aisa/
├── .claude_instructions      # AI behavior and protocols
├── system-inventory.json     # Complete system documentation (auto-generated)
├── README.md                 # This file
├── install.sh                # Installation script
├── .claude/
│   ├── settings.local.json   # Permissions configuration
│   ├── system-changes.log    # Change tracking history
│   ├── skills/               # Slash command definitions
│   │   ├── familiarize/
│   │   │   └── SKILL.md
│   │   ├── monitor-system/
│   │   │   └── SKILL.md
│   │   └── ... (21 skills)
│   ├── agents/               # Agent workflow definitions
│   ├── scripts/              # Utility scripts
│   ├── logs/                 # Operation logs
│   └── backups/              # Configuration backups
├── servers/                  # Service management scripts (auto-generated)
│   └── <service>/
│       ├── README.md
│       ├── check-<service>.sh
│       └── <service>.sh
├── templates/                # Script templates
│   ├── check-systemd-service.sh.template
│   ├── check-docker-service.sh.template
│   ├── manage-docker-service.sh.template
│   └── service-readme.md.template
└── reports/                  # Generated reports
```

## How It Works

### 1. System Discovery (`/familiarize`)

When you run `/familiarize`, AISA:
1. Scans hardware (CPU, memory, storage, GPU)
2. Discovers all running services
3. Maps Docker/Podman/LXD containers
4. Analyzes web server configurations
5. Checks SSL certificates
6. Documents network topology
7. Generates management scripts for each service
8. Creates comprehensive `system-inventory.json`

### 2. Change Management

All system changes are logged to `.claude/system-changes.log` with:
- Timestamp
- Action type
- Detailed description
- Files modified
- Impact assessment
- Rollback procedure

### 3. Service Management

For each discovered service, AISA creates:
- **Health check script** - Quick status and diagnostics
- **Management script** - Start/stop/restart/logs
- **README** - Service documentation

## Customization

### Adding Custom Skills

Create a new directory in `.claude/skills/` with a `SKILL.md` file:

```bash
mkdir -p .claude/skills/my-custom-command
```

Then create `.claude/skills/my-custom-command/SKILL.md`:

```markdown
---
name: my-custom-command
description: What this command does
---

# My Custom Command

Instructions for Claude to follow when this command is invoked.

## Usage

/my-custom-command <required-arg> [optional-arg]

## Process

1. Step one
2. Step two
```

**Note**: The skill file MUST be named exactly `SKILL.md` (case-sensitive) inside its own directory.

### Modifying Permissions

Edit `.claude/settings.local.json` to add or remove pre-approved commands:

```json
{
  "permissions": {
    "allow": [
      "Bash(my-custom-command:*)",
      "Read(/my/custom/path/**)"
    ]
  }
}
```

## Supported Systems

AISA works on any Linux system with:
- **OS**: Ubuntu, Debian, RHEL, CentOS, Fedora, Arch, etc.
- **Init**: systemd (primary), also supports SysV init
- **Containers**: Docker, Podman, LXD/LXC
- **Hardware**: x86_64, ARM64

## Best Practices

1. **Run `/familiarize` first** - Always start with system discovery
2. **Review the inventory** - Check `system-inventory.json` for accuracy
3. **Use slash commands** - They ensure consistent documentation
4. **Check the changelog** - Before making changes, review recent history
5. **Test before restart** - Use `/test-service` before `/restart-service`

## Troubleshooting

### Skills Not Loading

```bash
# Check skill directories exist with SKILL.md files
ls -la .claude/skills/*/SKILL.md

# Verify skill file format (YAML frontmatter)
head -10 .claude/skills/familiarize/SKILL.md

# Skills require Claude Code restart to load
# Close and reopen Claude Code after adding new skills
```

### Permission Errors

```bash
# Verify settings.local.json is valid JSON
python3 -c "import json; json.load(open('.claude/settings.local.json'))"
```

### Service Not Detected

Run `/update-inventory` to refresh, or manually add the service to `system-inventory.json`.

## Contributing

To improve AISA:
1. Fork this repository
2. Make your changes
3. Test on a fresh system
4. Submit a pull request

## License

MIT License - Use freely for personal and commercial purposes.
