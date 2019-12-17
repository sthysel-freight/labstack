#!/usr/bin/env sh

target=${1:-localhost}

if [ $target == "localhost" ]
then
    ansible-playbook -v -i $target, site.yml -K --connection local
else
    ansible-playbook -v -i $target, site.yml -K
fi
