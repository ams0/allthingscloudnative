# Desktop prep script for Kubernetes


# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo apt-get install build-essential
echo >> /home/student/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/student/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install gcc

# aliases
curl https://raw.githubusercontent.com/ahmetb/kubectl-alias/master/.kubectl_aliases -o ~/.kubectl_aliases ; source ~/.kubectl_aliases
echo "source ~/.kubectl_aliases" >> ~/.bashrc

# install k9s
brew install derailed/k9s/k9s

# install kubectl
brew install kubectl kubectx kubens kube-ps1

source "/home/linuxbrew/.linuxbrew/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1

#kubectl completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
source <(kubectl completion bash)
