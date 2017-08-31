#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Copyright (c) 2017 Jamf.  All rights reserved.
#
#       Redistribution and use in source and binary forms, with or without
#       modification, are permitted provided that the following conditions are met:
#               * Redistributions of source code must retain the above copyright
#                 notice, this list of conditions and the following disclaimer.
#               * Redistributions in binary form must reproduce the above copyright
#                 notice, this list of conditions and the following disclaimer in the
#                 documentation and/or other materials provided with the distribution.
#               * Neither the name of the Jamf nor the names of its contributors may be
#                 used to endorse or promote products derived from this software without
#                 specific prior written permission.
#
#       THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY
#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# This script was designed to be used as an Extension Attribute to ensure specific
# requirements have been met to deploy macOS High Sierra.
# 
# General Requirements:
# 	- OS X 10.7.5 or later
# 	- 4GB of memory (Apple says 2GB for 10.12, I prefer having a minimum of 4GB)
# 	- 15GB of available storage (Apple says 8.8GB for 10.12, I prefer more space)
# 
# These last 2 requirements can be modified in the first 2 variables (MINIMUMRAM
# and MINIMUMSPACE).
# 	- MINIMUMRAM: minimum RAM required, in GB
# 	- MINIMUMSPACE: minimum disk space available, in Bytes
# 
# To convert GigaBytes to Bytes, multiply the value in GB by 1024, the result by
# 1024 and again by 1024, for example, for 15GB of disk space:
# 
# 	15 * 1024 * 1024 * 1024 = 10737418240 Bytes
# 
# Mac Hardware Requirements
# 	- MacBook (Late 2009 or newer)
# 	- MacBook Pro (Mid 2010 or newer)
# 	- MacBook Air (Late 2010 or newer)
# 	- Mac mini (Mid 2010 or newer)
# 	- iMac (Late 2009 or newer)
# 	- Mac Pro (Mid 2010 or newer)
#
# Default compatibility is set to False if no test pass (variable COMPATIBILITY)
#
# Written by: Laurent Pertois | Senior Professional Services Engineer | Jamf
#
# Created On: 2017-08-27
# Updated On: 2017-08-31
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Minimum RAM and Disk Space required (4GB and 15GB here)
MINIMUMRAM=4
MINIMUMSPACE=10737418240 # 15*1024*1024*1024

#########################################################################################
############### DO NOT CHANGE UNLESS NEEDED
#########################################################################################

# Default values for Compatibility is false
COMPATIBILITY="False"

#########################################################################################
############### Let's go!
#########################################################################################

# Checks minimum version of the OS before upgrade (10.7.5)
OSVERSIONMAJOR=$(sw_vers -productVersion | awk -F"." '{ print $2 }')
OSVERSIONMINOR=$(sw_vers -productVersion | awk -F"." '{ print $3 }')

# Checks if computer meets pre-requisites for High Sierra
if [[ "$OSVERSIONMAJOR" -ge 8 && "$OSVERSIONMAJOR" -lt 13 || "$OSVERSIONMAJOR" -eq 7 && "OSVERSIONMINOR" -eq 5 ]]; then
	# Gets System Information informations about hardware and Storage
	SPHARDWARE=$(system_profiler SPHardwareDataType)

	# Gets the Model Identifier, splits name and major version
	MODELIDENTIFIER=$(echo "$SPHARDWARE" | awk '/Model Identifier/ { print $3 }')
	MODELNAME=$(echo "$MODELIDENTIFIER" | sed 's/[^a-zA-Z]//g')
	MODELVERSION=$(echo "$MODELIDENTIFIER" | sed 's/[^0-9,]//g' | awk -F, '{print $1}')

	# Gets amount of memory installed
	MEMORYINSTALLED=$(echo "$SPHARDWARE" | awk '/Memory/ { print $2 }')

	# Gets free space on the boot drive
	FREESPACE=$(diskutil info / | awk -F'[()]' '/Free Space|Available Space/ {print $2}' | sed -e 's/\ Bytes//')
	
	# Checks if computer meets pre-requisites for High Sierra
	if [[ "$MODELNAME" == "iMac" && "$MODELVERSION" -ge 10 && "$MEMORYINSTALLED" -ge "$MINIMUMRAM" && "$FREESPACE" -ge "$MINIMUMSPACE" ]]; then
		COMPATIBILITY="True"
	elif [[ "$MODELNAME" == "Macmini" && "$MODELVERSION" -ge 4 && "$MEMORYINSTALLED" -ge "$MINIMUMRAM" && "$FREESPACE" -ge "$MINIMUMSPACE" ]]; then
		COMPATIBILITY="True"
	elif [[ "$MODELNAME" == "MacPro" && "$MODELVERSION" -ge 5 && "$MEMORYINSTALLED" -ge "$MINIMUMRAM" && "$FREESPACE" -ge "$MINIMUMSPACE" ]]; then
	    COMPATIBILITY="True"
	elif [[ "$MODELNAME" == "MacBook" && "$MODELVERSION" -ge 6 && "$MEMORYINSTALLED" -ge "$MINIMUMRAM" && "$FREESPACE" -ge "$MINIMUMSPACE" ]]; then
	    COMPATIBILITY="True"
	elif [[ "$MODELNAME" == "MacBookAir" && "$MODELVERSION" -ge 3 && "$MEMORYINSTALLED" -ge "$MINIMUMRAM" && "$FREESPACE" -ge "$MINIMUMSPACE" ]]; then
	    COMPATIBILITY="True"
	elif [[ "$MODELNAME" == "MacBookPro" && "$MODELVERSION" -ge 7 && "$MEMORYINSTALLED" -ge "$MINIMUMRAM" && "$FREESPACE" -ge "$MINIMUMSPACE" ]]; then
	    COMPATIBILITY="True"
	fi

	# Outputs result
	echo "<result>$COMPATIBILITY</result>"
else
	echo "<result>$COMPATIBILITY</result>"
fi
