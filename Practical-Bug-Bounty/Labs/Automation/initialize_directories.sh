#!/bin/bash

# Set the domain variable from the first argument
domain=$1

# Define color variables for terminal output
RED="\033[1;31m"
RESET="\033[0m"

# Define paths for storing outputs
subdomain_path=$domain/subdomains
screenshot_path=$domain/screenshots
scan_path=$domain/scans

# Check and create the main directory for the domain
if [ ! -d "$domain" ]; then
    mkdir $domain
fi

# Check and create the subdomain directory
if [ ! -d "$subdomain_path" ]; then
    mkdir $subdomain_path
fi

# Check and create the screenshot directory
if [ ! -d "$screenshot_path" ]; then
    mkdir $screenshot_path
fi

# Check and create the scan directory
if [ ! -d "$scan_path" ]; then
    mkdir $scan_path
fi
