#!/usr/bin/env python

import os
import sys
import subprocess

if os.geteuid() == 0:
	print("root user!")
	subprocess.call(['./launchControlFan.sh', '1'])
	sys.exit()
else:
	print("We're not root.")
	subprocess.call(['sudo', './launchControlFan.sh', '1'])
	sys.exit()
