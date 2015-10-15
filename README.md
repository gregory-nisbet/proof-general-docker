# proof-general-docker
A Dockerfile with emacs and proof-general set up and ready to go.

## Instructions
This image is named `gregorynisbet/proof-general-emacs` and is on dockerhub.

1. `sudo bash build.sh` builds the image locally
2. `sudo bash run.sh` runs the image in a container

## TODO
1. Run a containerized graphical Emacs (i.e. mount X socket in the run script)
2. Replace Fedora base image with something smaller
3. Mount host file system in a convenient way (i.e. no /mnt everywhere)
