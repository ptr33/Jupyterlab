FROM python:3.13

# Install nicer Bash terminal
RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  bash ~/.bash_it/install.sh --silent

# Install NodeJS 22
RUN curl -sL https://deb.nodesource.com/setup_22.x | bash - && \
  apt-get upgrade -y && \
  apt-get install -y nodejs texlive-latex-extra texlive-xetex && \
  rm -rf /var/lib/apt/lists/*


# install Rust (needed for y-py) - see https://rustup.rs/
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add .cargo/bin to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Check cargo is visible
RUN cargo --help

# Install packages and extensions for JupyterLab
RUN pip install --upgrade pip && \
  pip install --upgrade \
    jupyterlab>=4.4.6 \
    ipywidgets \
    jupyter-lsp \
    python-language-server \
    jupyterlab-git \
    jupyter_bokeh \
    jupyterlab_widgets \
    jupyterlab_latex \
    jupyterlab-lsp \
    'python-lsp-server[all]' \
    jupyterlab-git \
    jupyterlab-spreadsheet-editor \
    lckr-jupyterlab-variableinspector \
    jupyterlab-filesystem-access
    
# from plotly documentation: install jupyter-dash

# install python library
COPY requirements.txt .
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt \
    && rm -rf ~/.cache/pip && \
    apt-get update && \
    apt-get install -y pandoc

RUN jupyter lab build

COPY bin/entrypoint.sh /usr/local/bin/
COPY config/jupyter_notebook_config.py /root/.jupyter/
# COPY config/ /root/.jupyter/

EXPOSE 8888
VOLUME /notebooks
WORKDIR /notebooks
ENTRYPOINT ["entrypoint.sh"]
