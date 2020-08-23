FROM python:3

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  bash ~/.bash_it/install.sh --silent

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get upgrade -y && \
  apt-get install -y nodejs texlive-latex-extra texlive-xetex && \
  rm -rf /var/lib/apt/lists/*

# Install Java
RUN apt-get update -y && \
    apt-get install -y default-jre
ENV JAVA_HOME /usr/lib/jvm/default-java/

RUN pip install --upgrade pip && \
  pip install --upgrade \
    jupyterlab>=2.0.0 \
    ipywidgets \
    jedi==0.15.2 \ 
    # jupyterlab-lsp does not support 0.17
    jupyterlab_latex \
    plotly \
    bokeh \
    numpy \
    scipy \
    numexpr \
    patsy \
    scikit-learn \
    scikit-image \
    matplotlib \
    ipython \
    pandas \
    sympy \
    seaborn \
    nose \
    # jupyter-lsp \
    # python-language-server \
    jupyterlab-git && \
    # FAIRWorkflowsExtension && \
  jupyter labextension install \
    @jupyter-widgets/jupyterlab-manager \
    @jupyterlab/latex \
    jupyterlab-drawio \ 
    jupyterlab-plotly \
    @bokeh/jupyter_bokeh \
    # @krassowski/jupyterlab-lsp \
    @jupyterlab/git \
    jupyterlab-spreadsheet 
    # FAIRWorkflowsExtension

# Install JupyterLab FAIRWorkflowsExtension
RUN pip install git+git://github.com/fair-workflows/FAIRWorkbench@master
RUN pip install git+git://github.com/fair-workflows/FAIRWorkflowsExtension@master
RUN git clone https://github.com/fair-workflows/FAIRWorkflowsExtension /root/FAIRWorkflowsExtension
WORKDIR /root/FAIRWorkflowsExtension
RUN jupyter-serverextension enable --py FAIRWorkflowsExtension 
RUN jlpm && jlpm build && jupyter-labextension link . && jlpm build && jupyter-lab build

# RUN pip install git+git://github.com/fair-workflows/FAIRWorkbench@add_nanopub_search_things_grlc
RUN pip install git+git://github.com/fair-workflows/NanopubJL@master
RUN git clone https://github.com/fair-workflows/NanopubJL /root/NanopubJL
WORKDIR /root/NanopubJL
RUN jupyter-serverextension enable --py NanopubJL && \
    jlpm && jlpm build && jupyter-labextension link . && jlpm build && jupyter-lab build

COPY bin/entrypoint.sh /usr/local/bin/
COPY config/ /root/.jupyter/

EXPOSE 8888
VOLUME /notebooks
WORKDIR /notebooks
ENTRYPOINT ["entrypoint.sh"]
