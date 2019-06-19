#!/bin/sh

echo $(lsb_release -i | cut -d: -f2)
