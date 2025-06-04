### Log into github using the gh client

```bash
brew install gh
gh auth login --hostname ghcr.io --git-protocol https
```

#### Refresh your GitHub CLI authentication to add the package scopes

```bash
gh auth refresh -h github.com -s read:packages -s write:packages
```

### Build this manually

Login to your github account with

```bash
echo YOUR_GITHUB_TOKEN | docker login ghcr.io -u YOUR_GITHUB_USERNAME --password-stdin
```

You can build and push your changes with

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t ghcr.io/pulibrary/pul_containers:jammy_multi --push .
```
