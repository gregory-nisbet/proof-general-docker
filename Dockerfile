FROM fedora:22
# install emacs
RUN dnf install -y emacs
# install make, whch (for makefile)
RUN dnf install -y make which
# copy proof general tar-gz
RUN mkdir -p /opt/ProofGeneral
ADD ./ProofGeneral-4.2.tgz /opt/ProofGeneral
# clean up .elc files
# on the off-chance they are incompatible with the
# current emacs version
# for whatever reason, make compile produces a bunch of nasty errors
# so we will not bother to byte compile until I can fix it.
RUN (cd /opt/ProofGeneral/ProofGeneral-4.2 && make clean)
# add init.el to .emacs
COPY ./init.el /tmp/init.el
RUN mkdir ~/.emacs.d
RUN mv /tmp/init.el ~/.emacs.d/init.el
ENTRYPOINT /bin/bash
