#!/bin/bash

#Wrapper for ssh-keygen with ed25519 and good practices


set -e

if [ $# -ne 2 ]; then
    echo -e "Usage: $0 <key_name> <email>"
    echo -e "Example: $0 my_github_key it-monkey@yourmail.com"
    exit 1
fi

KEY_NAME="$1"
EMAIL="$2"
SSH_PATH="$HOME/.ssh"
KEY_PATH="${SSH_PATH}/${KEY_NAME}_ed25519"

if [ ! -d "$SSH_PATH" ]; then
	echo -e "$SSH_PATH doesn't exist. Creating..."	
	mkdir -p $SSH_PATH && echo $(ls -ld $SSH_PATH)
	chmod 700 ~/.ssh
fi

ssh-keygen -t ed25519 -a 100 -f "$KEY_PATH" -C "$EMAIL" -N ""
chmod 600 "$KEY_PATH"
chmod 644 "${KEY_PATH}.pub"

echo "SSH key created: $KEY_PATH"
echo "Public key:"
cat "${KEY_PATH}.pub"

exit 0
