#!/bin/bash

echo "=== AUTOMATED BACKUP SCRIPT ==="

read -p "Enter directory to backup: " source

if [ ! -d "$source" ]; then
    echo "Source directory does not exist!"
    exit 1
fi


read -p "Enter backup destination: " destination

if [ ! -d "$destination" ]; then
    echo "Destination does not exist!"
    exit 1
fi

echo "Backup Type:"
echo "1. Simple copy"
echo "2. Compressed archive (tar.gz)"
read -p "Enter choice: " choice

timestamp=$(date +"%Y%m%d_%H%M%S")

start_time=$(date +%s)

echo "[*] Starting backup..."
echo "[*] Source: $source"
echo "[*] Destination: $destination"

if [ "$choice" -eq 1 ]; then
    backup_name="backup_$timestamp"
    echo "[*] Creating simple copy..."
    cp -r "$source" "$destination/$backup_name"
    backup_path="$destination/$backup_name"

elif [ "$choice" -eq 2 ]; then
    backup_name="backup_$timestamp.tar.gz"
    echo "[*] Creating compressed archive..."
    tar -czf "$destination/$backup_name" -C "$(dirname "$source")" "$(basename "$source")"
    backup_path="$destination/$backup_name"

else
    echo "Invalid choice!"
    exit 1
fi

end_time=$(date +%s)
time_taken=$((end_time - start_time))

if [ -e "$backup_path" ]; then
    echo "Backup completed successfully!"
else
    echo "Backup failed!"
    exit 1
fi

size=$(du -sh "$backup_path" | awk '{print $1}')

echo "Backup Details:"
echo " File: $backup_name"
echo " Location: $destination"
echo " Size: $size"
echo " Time taken: $time_taken seconds"
