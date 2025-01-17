[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/amalic/Jupyterlab/blob/master/LICENSE)
[![Publish Docker image](https://github.com/ptr33/Jupyterlab/workflows/Publish%20Docker%20image/badge.svg)](https://github.com/users/ptr33/packages/container/package/jupyterlab)


## Jupyterlab Docker container

**This Docker container runs as root user!** It can be helpful when e.g. the popular jupyter/datascience-notebook image does not work because it runs as Jovyan user. 

Additional packages can be installed on creation of container by adding to requirements.txt.

Changed base url to make operation behind appache reverse proxy easier: http://localhost:8888/jupyter

#### Installed kernels

* Python 3.11 with autocomplete and suggestions ([LSP](https://github.com/krassowski/jupyterlab-lsp))

#### Installed Jupyterlab extensions
- [Jupyter Widgets](https://ipywidgets.readthedocs.io/en/latest/examples/Widget%20Basics.html)
- [@jupyterlab/git](https://www.npmjs.com/package/@jupyterlab/git)
- [@krassowski/jupyterlab-lsp](https://github.com/krassowski/jupyterlab-lsp)
- [@jupyterlab/latex](https://github.com/jupyterlab/jupyterlab-latex)
- [jupyterlab-plotly](https://www.npmjs.com/package/jupyterlab-plotly)
- [jupyterlab-drawio](https://github.com/QuantStack/jupyterlab-drawio)
- [jupyterlab-spreadsheet](https://github.com/quigleyj97/jupyterlab-spreadsheet)
- [@bokeh/jupyter_bokeh](https://github.com/bokeh/jupyter_bokeh)
- [@jupyterlab/toc](https://www.npmjs.com/package/@jupyterlab/toc)
- [lckr-jupyterlab-variableinspector](https://github.com/lckr/jupyterlab-variableInspector)
- [jupyterlab-filesystem-access](https://github.com/jupyterlab-contrib/jupyterlab-filesystem-access)

### Your notebooks

Volumes can be mounted into `/notebooks` folder.

The container will install requirements from files present in the `/notebooks` folder when it starts up (in this order):

- `packages.txt`: install apt-get packages
- `requirements.txt`: install pip packages
- `extensions.txt`: install JupyterLab extensions

---

### Pull/Update to latest version
```bash
docker pull ghcr.io/ptr33/jupyterlab:latest
```

### Run
```bash
docker run --rm -it -p 8888:8888 ghcr.io/ptr33/jupyterlab
```

or if you want to define your own password and shared volume:
```bash
docker run --rm -it -p 8888:8888 -v $(pwd)/data:/notebooks -e PASSWORD="password" ghcr.io/ptr33/jupyterlab
```

### Run from Git repository

You can provide a Git repository to be cloned in `/notebooks` when starting the container (it will automatically install packages if `requirements.txt`, `packages.txt` or `extensions.txt` are present at the root of the repository).

```bash
docker run --rm -it -p 8888:8888 -v /data/jupyterlab-notebooks:/notebooks -e PASSWORD="<your_secret>" -e GIT_URL="https://github.com/vemonet/translator-sparql-notebook" ghcr.io/ptr33/jupyterlab:latest
```

> Access on http://localhost:8888/jupyter and files shared in `/data/jupyterlab-notebooks`

or use the current directory as source code in the container:

```bash
docker run --rm -it -p 8888:8888 -v $(pwd):/notebooks -e PASSWORD="<your_secret>" ghcr.io/ptr33/jupyterlab:latest
```

> Use `${pwd}` for Windows

### Run with docker-compose

Add JupyterLab to a `docker-compose.yml` file:

```yaml
services:
  jupyterlab:
    container_name: jupyterlab
    image: ghcr.io/ptr33/jupyterlab
    ports:
      - 8888:8888
    volumes:
      - ./data:/notebooks
    environment:
      - PASSWORD=password
      - GIT_URL=https://github.com/vemonet/translator-sparql-notebook
```

### Build from source

Clone the repository, then build the container image:

```bash
git clone https://github.com/ptr33/Jupyterlab.git
cd Jupyterlab
docker build -t ghcr.io/ptr33/jupyterlab .
```
