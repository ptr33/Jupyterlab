[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/vemonet/Jupyterlab/blob/master/LICENSE)
[![Publish Docker image](https://github.com/vemonet/Jupyterlab/workflows/Publish%20Docker%20image/badge.svg)](https://github.com/users/vemonet/packages/container/package/jupyterlab)


## Jupyterlab Docker container

JupyterLab image based on the [jupyter/docker-stack](jupyter/docker-stack) scipy image

#### Installed kernels

* Python 3.8 with autocomplete and suggestions ([LSP](https://github.com/krassowski/jupyterlab-lsp))
* [IJava](https://github.com/SpencerPark/IJava) with current default JDK
* [SPARQL kernel](https://github.com/paulovn/sparql-kernel)

#### Installed Jupyterlab extensions

- [jupyterlab-git](https://github.com/jupyterlab/jupyterlab-git)
- [jupyterlab-lsp](https://github.com/krassowski/jupyterlab-lsp)

Volumes can be mounted into `/home/jovyan` folder.

---

### Pull/Update to latest version

```bash
docker pull ghcr.io/vemonet/jupyterlab:latest
```

### Run

```bash
docker run --rm -it -p 8888:8888 ghcr.io/vemonet/jupyterlab
```

or if you want to define your own password, run with `sudo` privileges, and share the current directory as a volume:

```bash
docker run --rm -it -p 8888:8888 -u root -e GRANT_SUDO=yes -v $(pwd)/data:/home/jovyan -e JUPYTER_TOKEN="password" ghcr.io/vemonet/jupyterlab
```

> Use `${pwd}` for Windows current directory

### Run with docker-compose

Add JupyterLab to a `docker-compose.yml` file:

```yaml
services:
  jupyterlab:
    container_name: jupyterlab
    image: ghcr.io/vemonet/jupyterlab
    ports:
      - 8888:8888
    volumes:
      - ./data:/home/jovyan
    environment:
      - JUPYTER_TOKEN=mypassword
```

### Run on Kubernetes OpenShift

Checkout the provided OpenShift template in `template-jupyterlab-root.yml` to easily deploy this JupyterLab with `sudo` permissions (require the `anyuid` service account to be present). This template can be used with most images based on the [jupyter/docker-stack](jupyter/docker-stack).

### Build from source

Clone the repository, then build the container image:

```bash
docker build -t ghcr.io/vemonet/jupyterlab .
```