FROM python:3.10

# Install nicer Bash terminal
RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  bash ~/.bash_it/install.sh --silent

# Install NodeJS 14
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get upgrade -y && \
  apt-get install -y nodejs texlive-latex-extra texlive-xetex && \
  rm -rf /var/lib/apt/lists/*

# Install packages and extensions for JupyterLab
RUN pip install --upgrade pip && \
  pip install --upgrade \
    jupyterlab>=3.0.0 \
    ipywidgets \
    jupyter-lsp \
    python-language-server \
    jupyterlab-git \
    jupyter_bokeh \
    jupyterlab_widgets \
    jupyterlab_latex \
    jupyterlab-drawio \
    jupyterlab-lsp \
    'python-lsp-server[all]' \
    jupyterlab-git \
    jupyterlab-spreadsheet-editor \
    jupyter-dash \
    lckr-jupyterlab-variableinspector
# from plotly documentation: install jupyter-dash

# install python library
COPY requirements.txt .
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt \
    && rm -rf ~/.cache/pip && \
    apt-get update && \
    apt-get install -y pandoc

RUN jupyter labextension install jupyterlab-filesystem-access && \
    jupyter lab build

COPY bin/entrypoint.sh /usr/local/bin/
COPY config/jupyter_notebook_config.py /root/.jupyter/
# COPY config/ /root/.jupyter/

EXPOSE 8888
VOLUME /notebooks
WORKDIR /notebooks
ENTRYPOINT ["entrypoint.sh"]



## Old pip install for data science:

    # jedi==0.15.2 \ 
    # # jupyterlab-lsp does not support 0.17
    # jupyterlab_latex \
    # plotly \
    # bokeh \
    # numpy \
    # scipy \
    # numexpr \
    # patsy \
    # scikit-learn \
    # scikit-image \
    # matplotlib \
    # ipython \
    # pandas \
    # sympy \
    # seaborn \
    # nose \
