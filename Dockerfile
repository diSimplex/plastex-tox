# A Dockerfile to use testing PlasTeX using Tox
#
# see: https://github.com/plastex/plastex/blob/master/CONTRIBUTING.md
# see: https://tox.wiki/en/latest/
# see: https://github.com/pyenv/pyenv
# see: https://virtualenv.pypa.io/en/latest/user_guide.html
# see: https://tug.org/texlive/

FROM python

# We work in /root (since then a `cd` puts us home)
WORKDIR /root
RUN mkdir /root/plastex /root/toxDir

# Add the packages required to build Python
RUN apt-get update && \
  apt-get --yes upgrade && \
  apt-get --yes install \
  build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
  libffi-dev liblzma-dev

# Add some useful packages as well as the TeXLive environment
# to provide any LaTeX tools PlasTex might want
RUN apt-get --yes install \
  less tree \
  texlive

# Install Tox
RUN pip install tox

# Install Pyenv in the /pyenv directory
RUN git clone https://github.com/pyenv/pyenv.git /pyenv && \
  cd /pyenv && src/configure && make -C src

# Add Pyenv to the system path
ENV PYENV_ROOT=/pyenv
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

# Install the various Pythons required by the PlaxTeX Tox.ini
RUN pyenv install 3.6 && \
  pyenv install 3.7 && \
  pyenv install 3.8 && \
  pyenv install 3.9 && \
  pyenv install 3.10 && \
  pyenv install 3.11 && \
  pyenv install 3.12 && \
  pyenv global 3.7 3.8 3.9 3.10 3.11 3.12

# This is the typical Tox command used to run tox on the PlasTex sources
#
# tox --conf plastex/tox.ini --workdir /toxDir

