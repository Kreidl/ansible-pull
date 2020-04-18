#!/bin/bash

set -e

NODE_RUNNER_HOME=/etc/ansible/ansible-pull

bailout() {
	echo "node-runner: $*" >&2
	exit 2
}

git=/usr/bin/git


if [ -d "$NODE_RUNNER_HOME" ]; then
	source $NODE_RUNNER_HOME/node-runner.cf
else
	echo "$0: \$NODE_RUNNER_HOME is not a directory." >&2
	exit 1
fi

[ -x $git ] || bailout "Can't find $git or is not executable"

cd $NODE_RUNNER_HOME
OLD_HEAD=$(git rev-parse HEAD)
$git pull --quiet
NEW_HEAD=$(git rev-parse HEAD)

# exit if files did not change
[ $OLD_HEAD = $NEW_HEAD ] && exit 0

# Re-read our config, as it may have changed after pull

source $NODE_RUNNER_HOME/node-runner.cf

# Run the playbook

ansible-playbook ${playbook}
