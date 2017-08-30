# High-Sierra-Compatibility-Checker

This script was designed to be used as an Extension Attribute on Jamf Pro server to ensure specific requirements have been met to deploy macOS High Sierra. With little modification it can probably be used on other systems (Jamf Pro server requires the output of an Extension Attribute to be `echo "<result>$FOO</result>`).

## General Requirements:
  - OS X 10.7.5 or later
  - 4GB of memory (Apple says 2GB for 10.12, I prefer having a minimum of 4GB)
  - 15GB of available storage (Apple says 8.8GB for 10.12, I prefer more space)

These last 2 requirements can be modified in the first 2 variables (`MINIMUMRAM` and `MINIMUMSPACE`).
  - MINIMUMRAM: minimum RAM required, in GB
  - MINIMUMSPACE: minimum disk space available, in Bytes
 
To convert GigaBytes to Bytes, multiply the value in GB by 1024, the result by 1024 and again by 1024, for example, for 15GB of disk space:
  15 * 1024 * 1024 * 1024 = 10737418240 Bytes

## Mac Hardware Requirements
  - MacBook (Late 2009 or newer)
  - MacBook Pro (Mid 2010 or newer)
  - MacBook Air (Late 2010 or newer)
  - Mac mini (Mid 2010 or newer)
  - iMac (Late 2009 or newer)
  - Mac Pro (Mid 2010 or newer)

Default compatibility is set to False if no test pass (variable `COMPATIBILITY`)

## Installation

Copy the content of the script (`.sh` file) to a new Computer Extension Attribute or just download the existing Extension Attribute (`.xml`) file and upload it to the Computer Extension Attributes of your Jamf Pro server.
