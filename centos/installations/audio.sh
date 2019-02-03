#!/bin/bash
# Install
yum -y install alsa-utils alsa-lib wine-alsa
yum -y install pulseaudio pulseaudio-utils pulseaudio-module-* pulseaudio-lib* wine-pulseaudio -x *dev*
