#!/usr/bin/env bash

version=1.0.2
curl -fL https://github.com/yuru7/moralerspace/releases/download/v${version}/MoralerspaceNF_v${version}.zip -o /tmp/MoralerspaceNF_v${version}.zip
unzip -o /tmp/MoralerspaceNF_v${version}.zip -d /tmp/
mv /tmp/MoralerspaceNF_v${version}/*.ttf ~/Library/Fonts/
rm -rf /tmp/MoralerspaceNF_v${version}*
