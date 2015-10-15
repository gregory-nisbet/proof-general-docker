FROM fedora:22
# install emacs
RUN dnf install -y emacs
# install make, whch (for makefile)
RUN dnf install -y make which
# copy proof general tar-gz
RUN mkdir -p /opt/ProofGeneral
RUN mkdir -p /opt/scripts
ADD ./ProofGeneral-4.2.tgz /opt/ProofGeneral
COPY compile-elc.pl /opt/scripts/compile-elc.pl
# by sheer luck, File::Find 's find function
# traverses the .el files in the correct order
# `make compile` does not
RUN (cd /opt/ProofGeneral/ProofGeneral-4.2 && make clean && \
    perl /opt/scripts/compile-elc.pl)
# add init.el to .emacs
COPY ./init.el /tmp/init.el
RUN mkdir ~/.emacs.d
RUN mv /tmp/init.el ~/.emacs.d/init.el
ENTRYPOINT /bin/bash
