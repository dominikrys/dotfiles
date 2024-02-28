#!/bin/bash

echo "Opening Google Drive..."
open /Applications/Google\ Drive.app

echo "Waiting for Google Drive path to be available..."
while [ ! -d "/Users/drys/Library/CloudStorage/GoogleDrive-drys@gocardless.com/My Drive/Backup/logseq" ]; do
    sleep 1
done

echo "Syncing logseq directory"
rsync -avh --progress "/Users/drys/Documents/logseq/" "/Users/drys/Library/CloudStorage/GoogleDrive-drys@gocardless.com/My Drive/Backup/logseq/" 

echo "Sync completed successfully!"
