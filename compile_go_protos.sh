#!/bin/bash
#
# Copyright the Hyperledger Fabric contributors. All rights reserved.
#
# SPDX-License-Identifier: Apache-2.0

set -eu -o pipefail

mkdir -p build

repo="build"

if [ ! -d "$repo" ]; then
  echo "$repo does not exist"
  exit 1
fi

for protos in $(find . -name '*.proto' -exec dirname {} \; | sort -u); do
  # protoc "--go_out=plugins=grpc,paths=source_relative:$repo" "$protos"/*.proto
  protoc --go_out=build "$protos"/*.proto
  protoc --go-grpc_out=require_unimplemented_servers=false:build "$protos"/*.proto

done
