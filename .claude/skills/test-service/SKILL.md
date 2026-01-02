---
name: test-service
description: Test service functionality and health
---

# Service Testing

I'll perform comprehensive testing of the specified service to verify it's functioning correctly.

## Tests Performed

### 1. Basic Health
- Service/container is running
- Process is responding
- No restart loops

### 2. Network Connectivity
- Listening on expected ports
- Accepting connections
- Response times acceptable

### 3. API/Endpoint Testing
- Health endpoints respond
- Basic functionality works
- Authentication (if applicable)

### 4. Resource Usage
- Memory within limits
- CPU usage normal
- Disk I/O acceptable

### 5. Log Analysis
- No recent errors
- No warning patterns
- Normal operation logs

### 6. Dependency Checks
- Database connectivity
- External service access
- Required files exist

## Test Methods by Service Type

### Web Services
```bash
curl -I http://localhost:<port>/
curl -I http://localhost:<port>/health
```

### Databases
```bash
# PostgreSQL
pg_isready -h localhost -p 5432

# MySQL
mysqladmin ping

# Redis
redis-cli ping
```

### Docker Containers
```bash
docker exec <container> <health-command>
```

## Output

Test results will include:
- Pass/Fail status for each test
- Response times
- Any errors encountered
- Recommendations if issues found

Let me test the service...
