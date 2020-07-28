#!/usr/bin/env bash

##
# @license Copyright 2020 The Lighthouse Authors. All Rights Reserved.
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
##

if [ x"$DEVTOOLS_PATH" == x ]; then
  echo "Error: Environment variable DEVTOOLS_PATH not set"
  exit 1
fi

if [ -d "$DEVTOOLS_PATH" ]
then
  echo "Directory $DEVTOOLS_PATH already exists."
  cd "$DEVTOOLS_PATH"

  git checkout 3dc032a7f76a2b80d1e58676473aaaaf464f74f4 # [1]
  # git fetch origin
  # git checkout origin/master
  gclient sync

  gn gen out/Default
  exit 0
fi

mkdir -p `dirname $DEVTOOLS_PATH`
cd `dirname $DEVTOOLS_PATH`
fetch devtools-frontend
cd devtools-frontend

git checkout 3dc032a7f76a2b80d1e58676473aaaaf464f74f4 && gclient sync # [1]
gn gen out/Default

# [1] Temporary. Latest DevTools fails to build.
