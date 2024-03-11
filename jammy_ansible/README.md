### Build this manually

Login to your quay account with

```bash
docker login quay.io
```

You can build and push your changes with 

```bash
docker build -t quay.io/pulibrary/jammy-ansible .
docker push quay.io/pulibrary/jammy-ansible:latest
```
