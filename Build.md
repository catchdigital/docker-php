# docker-php

How to build the image manually with multi-arch support.

Following the [article published by docker](https://www.docker.com/blog/multi-arch-images/), we can make the image compatible with a number of architectures.

For this image, we will support Intel based and Apple Silicon architectures.

In order to build the image, we need to use buildx, as follow:

Check if there is a buildx set up already:
```
docker buildx ls
```

Create a new builder (Do not user the default, which is the old one):
```
docker buildx create --name mybuilder
```

Use your builder:
```
docker buildx use mybuilder
```

Check the support of your builder:
```
docker buildx inspect --bootstrap
```

Build your image with the required platforms:
```
docker buildx build --platform linux/arm64,linux/amd64 -t catchdigital/php:7.4.25-fpm . --load
```

If new architectures need support, we will need to update the Dockerfile with the required architectures.
Sample of architectures:
```
RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" \
  && case "${dpkgArch##*-}" in \
    amd64) ARCH='x64';; \
    ppc64el) ARCH='ppc64le';; \
    s390x) ARCH='s390x';; \
    arm64) ARCH='arm64';; \
    armhf) ARCH='armv7l';; \
    i386) ARCH='x86';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac \
```
