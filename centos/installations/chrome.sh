#!/bin/bash
curl https://intoli.com/install-google-chrome.sh | bash
yum check-update

# DefaultApps
cat /usr/share/applications/defaults.list | grep video
cat /usr/share/applications/defaults.list | grep image
echo -e "x-scheme-handler/mailto=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "application/pdf=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "image/*=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "audio/x-mpegurl=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/mp4=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-flv=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/mpeg=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/webm=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "application/octet-stream=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "audio/x-vorbis+ogg=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/avi=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/flv=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/quicktime=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/vnd.rn-realvideo=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-matroska=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-ms-asf=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-msvideo=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-ms-wmv=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-ogm=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-theora=google-chrome.desktop">>.local/share/applications/mimeapps.list

# Set Proxy Pac File
PAC_PROPERTY=' --proxy-pac-url=file:///home/alograg/.config/openbox/local.pac'
sed -i "s|google-chrome-stable|& $PAC_PROPERTY|g" /usr/share/applications/google-chrome.desktop
