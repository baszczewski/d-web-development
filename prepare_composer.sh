#!/bin/bash

# phpunit
composer global require "phpunit/phpunit=5.3.*"
composer global require "phpunit/dbunit=2.0.*"

# export path
echo "export PATH=$PATH:/home/user/.composer/vendor/bin" >> /home/user/.bashrc
source /home/user/.bashrc