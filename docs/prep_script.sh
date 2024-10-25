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

# install krew
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

kubectl krew install tree node-admin resource-capacity neat