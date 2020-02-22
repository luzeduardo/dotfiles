#!/bin/bash
wget -O jetbrainsmono.zip https://download.jetbrains.com/fonts/JetBrainsMono-1.0.3.zip?_ga=2.215069079.1213771308.1582326733-1949071880.1582326733

unzip jetbrainsmono.zip
mv JetBrainsMono-1.0.3 ~/.fonts
rm jetbrainsmono.zip
sudo fc-cache -f -v
