#!/bin/bash
#
# AISA - AI System Administrator
# Installation Script
#
# Usage: ./install.sh [target-directory]
#
# This script installs AISA to the specified directory (default: ~/projects/aisa)
# After installation, run /familiarize to scan and document your system.

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${GREEN}[OK]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }

# Default installation directory
DEFAULT_DIR="$HOME/projects/aisa"
INSTALL_DIR="${1:-$DEFAULT_DIR}"

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║           AISA - AI System Administrator                     ║"
echo "║                 Installation Script                          ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

print_info "Installation directory: $INSTALL_DIR"

# Check if directory exists
if [ -d "$INSTALL_DIR" ]; then
    print_warn "Directory already exists: $INSTALL_DIR"
    read -p "Overwrite? (y/N): " confirm
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        print_info "Installation cancelled"
        exit 0
    fi
fi

# Create directory structure
print_info "Creating directory structure..."
mkdir -p "$INSTALL_DIR"/{.claude/{scripts,agents,logs,backups},servers,reports,templates}

# Get the script's directory (where the boilerplate files are)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy files
print_info "Copying AISA files..."

# Core files
cp "$SCRIPT_DIR/.claude_instructions" "$INSTALL_DIR/"
cp "$SCRIPT_DIR/system-inventory.json" "$INSTALL_DIR/"

# .claude directory
cp "$SCRIPT_DIR/.claude/settings.local.json" "$INSTALL_DIR/.claude/"
cp "$SCRIPT_DIR/.claude/system-changes.log" "$INSTALL_DIR/.claude/"

# Skills (new structure: each skill is a directory with SKILL.md)
print_info "Installing skills..."
cp -r "$SCRIPT_DIR/.claude/skills" "$INSTALL_DIR/.claude/"

# Agents
if [ -d "$SCRIPT_DIR/.claude/agents" ]; then
    cp -r "$SCRIPT_DIR/.claude/agents/"* "$INSTALL_DIR/.claude/agents/" 2>/dev/null || true
fi

# Templates
if [ -d "$SCRIPT_DIR/templates" ]; then
    cp "$SCRIPT_DIR/templates/"* "$INSTALL_DIR/templates/" 2>/dev/null || true
fi

# Set permissions
print_info "Setting permissions..."
chmod 755 "$INSTALL_DIR"
chmod 644 "$INSTALL_DIR/.claude_instructions"
chmod 644 "$INSTALL_DIR/system-inventory.json"
find "$INSTALL_DIR/.claude/skills" -name "SKILL.md" -exec chmod 644 {} \;
chmod 755 "$INSTALL_DIR/.claude/logs"
chmod 755 "$INSTALL_DIR/.claude/backups"

# Create README if not exists
if [ ! -f "$INSTALL_DIR/README.md" ]; then
    cp "$SCRIPT_DIR/README.md" "$INSTALL_DIR/" 2>/dev/null || \
    cat > "$INSTALL_DIR/README.md" << 'EOF'
# AISA - AI System Administrator

Professional system administration using Claude AI.

## Quick Start

1. Open this directory in Claude Code
2. Run `/familiarize` to scan and document your system
3. Use slash commands for system administration tasks

## Available Commands

- `/familiarize` - Scan and document the system (run first!)
- `/monitor-system` - Check system health
- `/check-security` - Security audit
- `/view-changelog` - View recent changes

See `.claude_instructions` for full documentation.
EOF
fi

print_status "Installation complete!"
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                    Next Steps                                ║"
echo "╠══════════════════════════════════════════════════════════════╣"
echo "║  1. Open the AISA directory in Claude Code:                  ║"
echo "║     cd $INSTALL_DIR"
echo "║                                                              ║"
echo "║  2. Run the familiarization command:                         ║"
echo "║     /familiarize                                             ║"
echo "║                                                              ║"
echo "║  This will scan your system and create:                      ║"
echo "║  - Complete system inventory                                 ║"
echo "║  - Management scripts for discovered services                ║"
echo "║  - Initial security audit                                    ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
