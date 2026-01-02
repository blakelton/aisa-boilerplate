---
name: monitor-resources
description: Monitor hardware resources (CPU, memory, disk, network)
---

# Resource Monitor

I'll check all hardware resources and their current utilization.

## Resources Checked

### CPU
- Current usage per core
- Load averages (1, 5, 15 min)
- Top CPU-consuming processes

### Memory
- Total/Used/Free RAM
- Swap usage
- Top memory-consuming processes
- Buffer/cache usage

### Disk
- Filesystem usage (all mounted)
- Inode usage
- I/O statistics
- SMART status (if available)

### Network
- Interface statistics
- Bandwidth usage
- Connection counts
- Packet errors/drops

### GPU (if present)
- Utilization
- Memory usage
- Temperature
- Power draw

## Commands

```bash
# CPU
lscpu
top -bn1 | head -20
cat /proc/loadavg

# Memory
free -h
cat /proc/meminfo | head -10

# Disk
df -h
df -i
iostat -x 1 1

# Network
ip -s link
ss -s
cat /proc/net/dev

# GPU
nvidia-smi
```

Let me gather resource information...
