---
name: monitor-hardware
description: Monitor hardware health (temperatures, SMART, UPS, sensors)
---

# Hardware Health Monitor

I'll check all hardware health indicators including temperatures, disk health, UPS status, and sensors.

## Checks Performed

### Temperature Sensors
- CPU temperature
- Motherboard sensors
- Drive temperatures
- GPU temperature (if present)

### Disk Health (SMART)
- Drive health status
- Bad sectors
- Pending sectors
- Reallocated sectors
- Power-on hours
- Temperature

### UPS Status (if present)
- Battery charge
- Load percentage
- Runtime remaining
- Input/Output voltage
- Recent events

### System Sensors
- Fan speeds
- Voltages
- Power consumption

## Commands

```bash
# Temperature sensors
sensors

# SMART status
smartctl -a /dev/sda
smartctl -H /dev/sda

# UPS (NUT)
upsc <ups-name>

# GPU
nvidia-smi --query-gpu=temperature.gpu,fan.speed,power.draw --format=csv
```

## Health Thresholds

| Metric | Warning | Critical |
|--------|---------|----------|
| CPU Temp | >70°C | >85°C |
| Disk Temp | >45°C | >55°C |
| UPS Battery | <50% | <20% |
| Disk Health | Degraded | Failed |

Let me check hardware health...
