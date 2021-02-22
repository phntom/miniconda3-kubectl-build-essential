FROM phntom/miniconda3-kubectl-build-essential:latest

RUN addgroup --gid 2004 xbuild && \
  adduser --uid 2004 --gid 2004 xbuild --disabled-password && \
  usermod -aG sudo xbuild && \
  groupadd --gid 2005 docker && \
  usermod -aG docker xbuild && \
  touch /var/run/docker.sock && \
  chown root:docker /var/run/docker.sock && \
  echo 'xbuild  ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/xbuild

USER xbuild
