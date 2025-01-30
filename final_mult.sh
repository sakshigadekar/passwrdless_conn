#!/bin/bash

SERVER_FILE="file.txt"  # File containing server details (user@ip password)
PUBLIC_KEY_FILE="$HOME/.ssh/id_rsa.pub"

# Generate SSH Key if Not Exists
if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "Generating a new SSH key..."
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
else
    echo "SSH key already exists at $PUBLIC_KEY_FILE"
fi

#  Read Servers from File and Copy SSH Key
while read -r SErver_IP Pass; do


    echo "Copying SSH key to $SERVER..."
    sshpass -p "$PASSWORD" ssh-copy-id -i "$PUBLIC_KEY_FILE" -o StrictHostKeyChecking=no "$SERVER"

    if [ $? -eq 0 ]; then
        echo "Successfully copied SSH key to $SERVER"
    else
        echo "Failed to copy SSH key to $SERVER"
    fi
done < "$SERVER_FILE"

echo "All servers processed."

