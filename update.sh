#!/bin/bash

render() {
sedStr="s/PHP_VERSION/$version/g"

sed "$sedStr" $1 > $2

cp -rf $version/install.sh $version/dev/install.sh
cp -rf $version/install.sh $version/prod/install.sh
}

versions=(5.6-fpm 7.1-fpm 7.2-fpm)
for version in ${versions[*]}; do
  render Dockerfile-dev.template $version/dev/Dockerfile
  render Dockerfile.template $version/prod/Dockerfile
done