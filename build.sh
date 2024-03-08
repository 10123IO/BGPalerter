#!/bin/bash

rm -rf bin
mkdir bin
npm run compile
./node_modules/.bin/pkg ./dist/package.json --options "no-warnings,max-old-space-size=4096" --targets node18-alpine-x64 --output bin/bgpalerter-linux-x64 --loglevel=error
rm -rf dist

