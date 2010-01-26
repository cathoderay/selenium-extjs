#!/bin/bash

sudo gem uninstall selenium-extjs
rake package
sudo gem i pkg/selenium-extjs-0.0.1.gem
