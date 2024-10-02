#!/bin/bash
magick $1 gif%05d.png && ffmpeg -r 24 -i gif%05d.png -y -an output.mp4 && rm gif*.png
