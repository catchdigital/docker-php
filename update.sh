#!/bin/bash

render() {
sedStr="s/PHP_VERSION/$version/g"

sed "$sedStr" $1 > $2

cp $version/install.sh $version/dev/install.sh
cp $version/install.sh $version/prod/install.sh
}

versions=(5.6 7.1 7.2)
for version in ${versions[*]}; do
  render Dockerfile-dev.template $version/dev/Dockerfile
  render Dockerfile.template $version/prod/Dockerfile
done