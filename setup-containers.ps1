# Stop and remove existing containers
docker stop ansible-host1 ansible-host2 ansible-host3
docker rm ansible-host1 ansible-host2 ansible-host3

# Create new containers with exposed SSH ports
docker run -d -p 2221:22 --name ansible-host1 ubuntu:latest sleep infinity
docker run -d -p 2222:22 --name ansible-host2 ubuntu:latest sleep infinity
docker run -d -p 2223:22 --name ansible-host3 ubuntu:latest sleep infinity

# Install SSH in each container
docker exec ansible-host1 bash -c "apt-get update && apt-get install -y openssh-server"
docker exec ansible-host2 bash -c "apt-get update && apt-get install -y openssh-server"
docker exec ansible-host3 bash -c "apt-get update && apt-get install -y openssh-server"

# Set root password and configure SSH
docker exec ansible-host1 bash -c "echo 'root:root' | chpasswd && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config"
docker exec ansible-host2 bash -c "echo 'root:root' | chpasswd && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config"
docker exec ansible-host3 bash -c "echo 'root:root' | chpasswd && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config"

# Start SSH service in each container
docker exec ansible-host1 bash -c "service ssh start"
docker exec ansible-host2 bash -c "service ssh start"
docker exec ansible-host3 bash -c "service ssh start"

# Get container IPs
Write-Host "Container IPs:"
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ansible-host1
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ansible-host2
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ansible-host3 