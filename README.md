# Mac Development Environment Setup

This is a repeatable checklist for setting up my development environment on a clean macOS install. It’s mostly for me, but I keep it readable in case someone else wants to see how I work.

---

## Prerequisites

| What                         | Why                             | Command                                       |
| ---------------------------- | ------------------------------- | --------------------------------------------- |
| **macOS updates**            | Start from a clean, patched OS  | `System Settings → General → Software Update` |
| **Xcode Command-Line Tools** | Needed for Homebrew & compilers | `xcode-select --install`                      |

---

## 1 · Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor  # Verify install
```

---

## 2 · Shell & Zsh Plugins

```bash
# Zsh itself (new macs include it, but this gets the latest)
brew install zsh

# Oh-My-Zsh (framework & plugin manager)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Plugins
brew install zsh-autosuggestions zsh-syntax-highlighting
```

### Copy Config Files

Everything is in the `config/` folder in this repo. Copy the files to your home directory:

| Source file              | Destination                                  |
| ------------------------ | -------------------------------------------- |
| `config/.gitconfig`      | `~/.gitconfig`                               |
| `config/.zshrc`          | `~/.zshrc`                                   |
| `config/sobol.zsh-theme` | `~/.oh-my-zsh/custom/themes/sobol.zsh-theme` |

`.zshrc` already includes:

```zsh
# Autosuggestions & syntax highlighting
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Local binaries & mise
export PATH="$HOME/.local/bin:$PATH"
eval "$(~/.local/bin/mise activate zsh)"
```

---

## 3 · Mise (Runtime Manager)

```bash
curl https://mise.run | sh
mise doctor
```

### Node + pnpm

```bash
mise install node@latest
mise use -g node@latest

corepack enable
corepack prepare pnpm@latest --activate
```

---

## 4 · Visual Studio Code

Install from: [https://code.visualstudio.com/](https://code.visualstudio.com/)

Settings Sync is enabled, so that will take care of extensions, themes, and settings.

See [`extensions.md`](extensions.md) for the list of extensions I use.

---

## 5 · Git & SSH

```bash
ssh-keygen -t ed25519 -C "$(git config user.email)" -f ~/.ssh/id_ed25519 -N ""
cat ~/.ssh/id_ed25519.pub
```

Copy the public key into GitHub under [SSH and GPG keys](https://github.com/settings/ssh/new).

To confirm Git is set up:

```bash
git config --list --show-origin
```

---

## 6 · Install Docker Desktop

[https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)

---

## 7 · Install Slack

[https://slack.com/downloads/mac](https://slack.com/downloads/mac)

---

## 8 · Install Zoom

[https://zoom.us/download](https://zoom.us/download)

---

## 9 · Install AWS CLI

```bash
brew install awscli
```

---

## 10 · Install Azure CLI

```bash
brew install azure-cli
```

---

## 11 · Post-Setup Checklist

* Restart Terminal / `source ~/.zshrc`
* `mise doctor` shows no issues
* `node -v`, `pnpm -v` return versions
* VS Code settings and extensions are synced
* SSH key works: `ssh -T git@github.com`
