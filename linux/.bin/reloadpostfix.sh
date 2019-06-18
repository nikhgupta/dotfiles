#!/bin/sh
postmap hash:/etc/postfix/recipient_access
service postfix restart
