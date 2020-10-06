Bootstrap: docker
From: continuumio/miniconda3:4.4.10

%labels
MAINTAINER statiksof

%environment
    # mount work and scratch
    export SINGULARITY_BINDPATH="/scratch, /work"

    # change conda path
    export PATH="/opt/conda/bin:/usr/local/bin:/usr/bin:/bin:"
    unset CONDA_DEFAULT_ENV
    export ANACONDA_HOME=/opt/conda

%post
    export PATH=/opt/conda/bin:$PATH
    # update and install pip
    apt-get -y update

    # clean apt
    apt-get autoremove -y
    apt-get clean

    # install packages
    conda config --add channels defaults
    conda config --add channels conda-forge
    conda install --yes jupyter
    conda clean --index-cache --tarballs --packages --yes

%runscript
    echo "Starting the notebook ..."
    echo "Open browser to localhost:8888"
    exec /usr/local/bin/jupyter notebook --ip='*' --port=8888 --no-browser
