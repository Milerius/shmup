#!/bin/bash

rm -rf bin/resources && cp -r resources bin
rm -rf bin/scripts && cp -r scripts bin
cp sf-config.json bin
