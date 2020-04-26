### WAVEWATCH III 6.07 Docker Container

This repo contains a recipe to build the third generation wave model WAVEWATCH
III TM inside a docker image.


### Usage

The easiest way is just pull the image from the docker-hub

```
docker pull dspelaez/ww3-docker:latest
```

In order to build the image you just have to type:

```
docker build -t ww3-docker .
```

Once the image have been created, you must create the container, to run it
interactively, just type

```
docker run -it --rm --name=ww3 ww3-docker /bin/bash
```

If you want to run interactively using your own data, so you have to mount a
volume that shares the host data with the container instance. To do that just
type:

```
docker run -it --rm --name=ww3 -v $(pwd):/root/ww3/work ww3-docker /bin/bash
```

in this case, `$(pwd)` represents the current directory, i.e., when your input
data is.

