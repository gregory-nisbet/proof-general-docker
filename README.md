# proof-general-docker
A Dockerfile with emacs and proof-general set up and ready to go.

## Instructions
This image is named `gregory-nisbet/proof-general` so as not to
conflict with anything

1. `sudo bash build.sh` builds the iamge
2. `sudo bash run.sh` runs the image in a container

## TODO
1. Fix error in Makefile or ProofGeneral so we get .elc files
2. Run a containerized graphical Emacs
3. Figure out how to host this thing on dockerhub
4. Replace Fedora base image with something smaller
