# High-Sierra-Compatibility-Checker

This script was designed to be used as an Extension Attribute on Jamf Pro server to ensure specific requirements have been met to deploy macOS High Sierra. With little modification it can probably be used on other systems (Jamf Pro server requires the output of an Extension Attribute to be `echo "<result>$FOO</result>`).

## General Requirements:
  - OS X 10.7.5 or later
  - 4GB of memory (Apple says 2GB for 10.12, I prefer having a minimum of 4GB)
  - 15GB of available storage (Apple says 8.8GB for 10.12, I prefer more space)

These last 2 requirements can be modified in the first 2 variables (`MINIMUMRAM` and `MINIMUMSPACE`).
  - REQUIREDMINIMUMRAM: minimum RAM required, in GB
  - REQUIREDMINIMUMSPACE: minimum disk space available, in GB
 

## Mac Hardware Requirements and equivalent as minimum Model Identifier
	- MacBook (Late 2009 or newer), ie MacBook6,1
	- MacBook Pro (Mid 2010 or newer), ie MacBookPro7,1
	- MacBook Air (Late 2010 or newer), ie MacBookAir3,1
	- Mac mini (Mid 2010 or newer), ie Macmini4,1
	- iMac (Late 2009 or newer), ie iMac10,1
	- Mac Pro (Mid 2010 or newer), ie MacPro5,1

Default compatibility is set to False if no test pass (variable `COMPATIBILITY`)

## Installation

Copy the content of the script (`.sh` file) to a new Computer Extension Attribute or just download the existing Extension Attribute (`.xml`) file and upload it to the Computer Extension Attributes of your Jamf Pro server.
