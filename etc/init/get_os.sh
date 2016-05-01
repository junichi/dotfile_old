#!/bin/bash

get_os() {
	case "$OSTYPE" in
		solaris*) PLATFORM="solaris" ;;
    	darwin*)  PLATFORM="osx"     ;; 
		linux*)   PLATFORM="linux"   ;;
		bsd*)     PLATFORM="bsd"     ;;
		*)        PLATFORM="unknown" ;;
	esac
	export PLATFORM
}