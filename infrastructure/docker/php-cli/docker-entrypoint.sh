#!/bin/bash

echo Starting Swoole!
/usr/bin/supervisord -n -c /etc/supervisord.conf
