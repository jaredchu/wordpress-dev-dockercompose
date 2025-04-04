# WordPress Dev Containers 🚀

A development Docker environment for WordPress with Xdebug integration for debugging.

## Features ✨

- WordPress with PHP 8.2
- MySQL 8.0
- phpMyAdmin
- Xdebug for debugging
- SSL support
- Persistent MySQL data
- Volume mounting for live code updates

## Prerequisites 📋

- Docker
- Docker Compose
- Git

## Quick Start 🚀

1. Clone the repository:
```bash
git clone https://github.com/jaredchu/wordpress-dev-dockercompose.git wordpress-dev
cd wordpress-dev
```

2. Set up environment:
```bash
cp .env.dev .env
cp ./config/xdebug.ini.dev ./config/xdebug.ini
```

3. Start the containers:
```bash
docker-compose up -d
```

4. Access your WordPress site at:
- WordPress: https://localhost
- phpMyAdmin: https://localhost:8080

## Available Services 🌐

| Service    | URL                | Default Credentials |
|------------|-------------------|---------------------|
| WordPress  | https://localhost | Create during setup |
| phpMyAdmin | https://localhost:8080 | root / (from .env) |

## Development Workflow 💻

1. **Code Changes**: Edit files in the `wordpress` directory
2. **Database Access**: Use phpMyAdmin at port 8080
3. **Debugging**: Configure your IDE to use Xdebug (port 9003)

## Environment Variables 🔧

Key variables in `.env`:
- `MYSQL_ROOT_PASSWORD`: Database root password
- `MYSQL_USER`: WordPress database user
- `MYSQL_PASSWORD`: WordPress database password
- `PHP_XDEBUG_BRANCH`: Xdebug version to install

## Debugging Setup 🔍

1. Configure Xdebug in your IDE:
   - Port: 9003
   - Host: localhost
   - Path mappings: `/var/www/html` → `./wordpress`

2. Enable debugging in browser:
   - Install Xdebug browser extension
   - Toggle debugging when needed

## Troubleshooting 🛠️

1. **Container won't start**:
   ```bash
   docker-compose down -v
   docker-compose up -d
   ```

2. **Permission issues**:
   ```bash
   sudo chown -R $USER:$USER wordpress/
   ```

3. **Database connection issues**:
   - Check MySQL service is running
   - Verify credentials in .env
   - Ensure ports are not blocked

## Contributing 🤝

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.
