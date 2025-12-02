#!/bin/bash

unzip day-tpl.zip

cargo generate --path ./day-tpl

rm -rf day-tpl
rm -rf __MACOSX
