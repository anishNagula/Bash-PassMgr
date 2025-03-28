#!/bin/bash

DATA_DIR="$HOME/.secure_pm"
DATA_FILE="$DATA_DIR/passwords.enc"

mkdir -p "$DATA_DIR"

if [ ! -f "$DATA_FILE" ]; then
    echo "No password database found. Setting up a new one..."
    read -s -p "Create a master password: " master_pass
    echo
    read -s -p "Confirm master password: " confirm_pass
    echo

    if [ "$master_pass" != "$confirm_pass" ]; then
        echo "Error: Passwords do not match. Setup failed!"
        exit 1
    fi

    touch temp_file
    openssl enc -aes-256-cbc -pbkdf2 -salt -in temp_file -out "$DATA_FILE" -pass pass:"$master_pass"
    rm temp_file
    echo "Password manager initialized successfully!"
else
    read -s -p "Enter master password: " master_pass
    echo
fi

echo -e "\nChoose an option:"
echo "1) View passwords"
echo "2) Add a new password"
echo "3) Remove a password"
read -r option

case "$option" in
    1)
        temp_file=$(mktemp)
        
        if ! openssl enc -d -aes-256-cbc -pbkdf2 -in "$DATA_FILE" -pass pass:"$master_pass" > "$temp_file"; then
            echo "Error: Incorrect master password or data corrupted!"
            exit 1
        fi

        printf "\n%-20s | %-25s | %-20s\n" "Service" "Username" "Password"
        printf "%s\n" "----------------------------------------------------------------------------"

        while IFS=: read -r service username password; do
            printf "%-20s | %-25s | %-20s\n" "$service" "$username" "$password"
        done < "$temp_file"

        rm "$temp_file"
        ;;
    2)
        read -p "For what (e.g., Gmail, GitHub): " forWhat
        read -p "Username: " username
        read -s -p "Password: " password
        echo
        
        temp_file=$(mktemp)
        
        if ! openssl enc -d -aes-256-cbc -pbkdf2 -in "$DATA_FILE" -pass pass:"$master_pass" > "$temp_file"; then
            echo "Error: Incorrect master password or data corrupted!"
            exit 1
        fi
        
        echo "$forWhat:$username:$password" >> "$temp_file"
        
        openssl enc -aes-256-cbc -pbkdf2 -salt -in "$temp_file" -out "$DATA_FILE" -pass pass:"$master_pass"
        
        rm "$temp_file"
        echo "Password added successfully!"
        ;;
    3)
        read -p "Enter the service to remove (e.g., Gmail): " service
        
        temp_file=$(mktemp)
        
        if ! openssl enc -d -aes-256-cbc -pbkdf2 -in "$DATA_FILE" -pass pass:"$master_pass" > "$temp_file"; then
            echo "Error: Incorrect master password or data corrupted!"
            exit 1
        fi
        
        grep -v "^$service:" "$temp_file" > "$temp_file.new" && mv "$temp_file.new" "$temp_file"
        
        openssl enc -aes-256-cbc -pbkdf2 -salt -in "$temp_file" -out "$DATA_FILE" -pass pass:"$master_pass"
        
        rm "$temp_file"
        echo "Password removed successfully!"
        ;;
    *)
        echo "Invalid option!"
        exit 1
        ;;
esac
