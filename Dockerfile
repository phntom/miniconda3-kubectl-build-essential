FROM debian:latest
MAINTAINER Anton Wolkov <anton@kix.co.il>

# based on https://hub.docker.com/r/conda/miniconda3/dockerfile
# added kubectl

RUN apt-get -qq update && \
  apt-get -qq -y install curl bzip2 gcc git locales build-essential bind9-host vim sudo && \
  curl -sL "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /bin/kubectl && \
  chmod +x /bin/kubectl && \
  curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
  curl -sL https://download.docker.com/linux/static/stable/x86_64/docker-20.10.14.tgz -o /tmp/docker-20.10.14.tgz && \
  tar xzf /tmp/docker-20.10.14.tgz -C /tmp/ && \
  mv -v /tmp/docker/* /usr/bin/ && \
  curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh && \
  bash /tmp/miniconda.sh -bfp /usr/local && \
  rm -rfv /tmp/* && \
  conda install -y python=3 && \
  conda update conda && \
  pip install --no-cache-dir awscli && \
  apt-get -qq -y autoremove && \
  apt-get autoclean && \
  rm -rf /var/lib/apt/lists/* /var/log/dpkg.log && \
  conda clean --all --yes

ENV PATH /opt/conda/bin:$PATH
