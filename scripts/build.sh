#!/bin/sh

set -eux

version=0.1.2

mkdir -p ./builds

platforms=("windows/amd64" "linux/amd64")

for platform in "${platforms[@]}"
do
    platform_split=(${platform//\// })
    GOOS=${platform_split[0]}
    GOARCH=${platform_split[1]}
    output_name='ssmps'
    if [ $GOOS = "windows" ]; then
        output_name+='.exe'
    fi

    env GOOS=$GOOS GOARCH=$GOARCH go build -ldflags "-X main.version=$version" -o $output_name main.go
    if [ $? -ne 0 ]; then
        echo 'An error has occurred! Aborting the script execution...'
        exit 1
    fi

    mv ./$output_name ./builds/$output_name
done
