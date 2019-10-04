#!/bin/sh
#!/usr/bin/python
# This is a comment!
##### Functions
#/home/manu/monitor/controlfan.py Quiet.rw >> log.txt

##### Constants
PATH="./"
CONFIG="Quiet.rw"
EJECT="controlfan.py"
EJECTSTART="launch.py"
RIGHT_NOW=$(/usr/bin/date  +"%x %r %Z")
LOG="logresult.txt"
TIME_STAMP="Log on $RIGHT_NOW by $USER"
start()
{
    # Temporary function stub

	$("/usr/bin/python" "./$EJECTSTART")
	return
}

	echo "starting..."
	start
	exit



