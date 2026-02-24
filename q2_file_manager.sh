
#!/bin/bash

while true
do
    echo "======================================"
    echo "         FILE & DIRECTORY MANAGER     "
    echo "======================================"
    echo "1. List files in current directory"
    echo "2. Create a new directory"
    echo "3. Create a new file"
    echo "4. Delete a file"
    echo "5. Rename a file"
    echo "6. Search for a file"
    echo "7. Count files and directories"
    echo "8. Exit"
    echo "======================================"
    read -p "Enter your choice [1-8]: " choice

    case $choice in

        1)
            echo "Listing files..."
            ls -lh
            ;;

        2)
            read -p "Enter directory name: " dirname
            if [ -d "$dirname" ]; then
                echo "Directory already exists!"
            else
                mkdir "$dirname" && echo "Directory created successfully."
            fi
            ;;

        3)
            read -p "Enter file name: " filename
            if [ -f "$filename" ]; then
                echo "File already exists!"
            else
                touch "$filename" && echo "File created successfully."
            fi
            ;;

        4)
            read -p "Enter file name to delete: " filename
            if [ -f "$filename" ]; then
                read -p "Are you sure you want to delete? (y/n): " confirm
                if [ "$confirm" = "y" ]; then
                    rm "$filename" && echo "File deleted successfully."
                else
                    echo "Deletion cancelled."
                fi
            else
                echo "File does not exist!"
            fi
            ;;

        5)
            read -p "Enter current file name: " oldname
            if [ -f "$oldname" ]; then
                read -p "Enter new file name: " newname
                mv "$oldname" "$newname" && echo "File renamed successfully."
            else
                echo "File does not exist!"
            fi
            ;;

        6)
            read -p "Enter filename or pattern to search: " pattern
            find . -name "$pattern"
            ;;

        7)
            files=$(find . -type f | wc -l)
            dirs=$(find . -type d | wc -l)
            echo "Number of files: $files"
            echo "Number of directories: $dirs"
            ;;

        8)
            echo "Exiting program..."
            break
            ;;

        *)
            echo "Invalid choice! Please enter a number between 1 and 8."
            ;;

    esac

    echo ""
done
