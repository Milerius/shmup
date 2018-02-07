#!/bin/bash

rm -rf bin/resources && cp -r resources bin
rm -rf bin/scripts && cp -r scripts bin
rm -rf bin/python && cp -r python bin
cp sf-config.json bin
