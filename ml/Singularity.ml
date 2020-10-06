Bootstrap: docker
From: continuumio/miniconda3:4.6.14

%labels
MAINTAINER statiksof

%environment
    # mount work and scratch
    export SINGULARITY_BINDPATH="/scratch, /work"

%post
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
    exec /opt/conda/bin/jupyter notebook --ip='*' --port=8888 --no-browser
