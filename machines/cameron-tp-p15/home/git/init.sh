#!/usr/bin/env bash

set -xeu

JSON=init.json

function clone_repos() {
        HOST=$1
        mapfile -d '\n' -t OWNERS < <(jq -r ".$HOST | keys[]" $JSON)
        for OWNER in $OWNERS; do
                for REPO in $(jq -r ".$HOST.$OWNER[]" $JSON); do
                        P=$HOST/$OWNER/$REPO.git
                        if [ ! -d "$P" ]; then
                                mkdir -p $HOST/$OWNER
                                git clone git@$HOST.com:$OWNER/$REPO.git $P
                        fi
                done
        done
}

clone_repos github
clone_repos gitlab
