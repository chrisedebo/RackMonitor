#!/bin/bash
sudo cp /boot/config.txt /boot/config.txt.backup
echo "dtoverlay=w1-gpio" | sudo tee -a /boot/config.txt
