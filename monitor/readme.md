The problem fan controll msi gs60:

pwmconfig reports that:

``
There are no pwm-capable sensors modules installed
``


I managed to have some control of the fan in Windows with the "Fan Control Tools" from Pherein, using the included GS660 profile for my MSI GS60 6QC laptop. So I made a small python script that is the Linux equivalent of Pherein's "Fan Profile Applier.exe":

``
#!/usr/bin/env python

import os
import sys

EC_IO_FILE="/sys/kernel/debug/ec/ec0/io"

if not os.path.exists(EC_IO_FILE):
        os.system("modprobe ec_sys write_support=1")

def ec_write(addr,value):
    with open(EC_IO_FILE,"rb") as f:
        f.seek(addr)
        old_value=ord(f.read(1))
    if (value != old_value):
        print("                %3d => %3d" % (old_value, value))
        with open(EC_IO_FILE,"wb") as f:
            f.seek(addr)
            f.write(bytearray([value]))
    else:
        print("                     = %3d" % value)

for line in open(sys.argv[1]).readlines():
    print(line.strip())
    if line.startswith(">WEC "):
        addr,value=line.split()[1:3]
        ec_write(int(addr,0), int(value,0))
``
Here is the input file I currently use as argument, it's the Quiet.rw file:

``
Profile Name: Quiet
[Temperatures_1]
>WEC 0x69 0x0
>WEC 0x6A 0x32
>WEC 0x6B 0x3B
>WEC 0x6C 0x44
>WEC 0x6D 0x4D
>WEC 0x6E 0x56
>WEC 0x6F 0x5F
----
[FanSpeeds_1]
>WEC 0x72 0x2C
>WEC 0x73 0x2C
>WEC 0x74 0x34
>WEC 0x75 0x3D
>WEC 0x76 0x47
>WEC 0x77 0x52
>WEC 0x78 0x5B
----
[Temperatures_2]
>WEC 0x81 0x0
>WEC 0x82 0x37
>WEC 0x83 0x41
>WEC 0x84 0x4B
>WEC 0x85 0x55
>WEC 0x86 0x5A
>WEC 0x87 0x5F
----
[FanSpeeds_2]
>WEC 0x8A 0x0
>WEC 0x8B 0x3B
>WEC 0x8C 0x46
>WEC 0x8D 0x54
>WEC 0x8E 0x5B
>WEC 0x8F 0x5B
>WEC 0x90 0x64
----
>RwExit
``
This file content in: GS60_FanProfiles

Launch:

``
sudo phyton controlfan.py Quiet.rw
``