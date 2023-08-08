echo "$SEPARATOR  Installing Docker $SEPARATOR"

echo "Update the apt package index and install packages to allow apt to use a repository over HTTPS:"
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

echo "Add Docker’s official GPG key"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "Use the following command to set up the repository:"
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Update the apt package index"
sudo apt-get update

echo "To install the latest version, run"
yes | sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Test Hello World"
sudo docker run hello-world