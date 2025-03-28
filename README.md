# 🔐 Simple Password Manager (Bash + OpenSSL)

A minimal password manager that securely stores your credentials using AES-256 encryption with OpenSSL.
No cloud storage, no third-party dependencies—just a lightweight, local password manager.

## 📌 Features

✅ AES-256 encrypted storage (using OpenSSL)  
✅ Master password protection  
✅ Add, View, and Remove passwords  
✅ Lightweight & works on any Linux/macOS system  

## 🛠 Installation (Any OS)

### 1. Clone the Repository
```sh
git clone https://github.com/anishNagula/Simple-Password-Manager-Bash-OpenSSL-.git
mv Simple-Password-Manager-Bash-OpenSSL- password_manager
cd password-manager
```

### 2. Make the Script Executable
```sh
chmod +x password_manager.sh
```

### 3. Move it to a System-Wide Location (Optional)
If you want to use the script from anywhere:
```sh
sudo mv password_manager.sh /usr/local/bin/password_manager
```
Now you can run the script by simply typing:
```sh
password_manager
```

## 🔑 First-Time Setup

Run the script:
```sh
./password_manager.sh
```
Since this is the first time, you will be prompted to set up a master password.
This master password will be used to encrypt and decrypt your password database.
You must confirm the master password before setup is completed.

A secure password file will be created at:
```sh
~/.secure_pm/passwords.enc
```
You’re now ready to store and manage passwords securely! 🎉

## 🚀 Usage Guide

After setup, you can use the password manager as follows:

### 🔍 View Stored Passwords
```sh
password_manager
```
- Enter your master password.
- You’ll see a table of saved passwords.

### ➕ Add a New Password
```sh
password_manager
```
- Select option `A`.
- Enter the service name (e.g., GitHub).
- Enter your username & password.
- The password is securely encrypted and stored.

### ❌ Remove a Password
```sh
password_manager
```
- Select option `R`.
- Type the service name you want to remove.
- That entry is deleted from your password database.

## 🔐 Security Notes

🔹 Your master password is NOT stored anywhere! If you forget it, there’s no recovery option.  
🔹 Passwords are only decrypted in memory and never saved in plaintext.  
🔹 Everything is stored locally—no cloud storage or third-party services.  

## 🛠 Uninstalling

If you want to remove the password manager:
```sh
rm -rf ~/.secure_pm
rm /usr/local/bin/password_manager  # (If you moved it to /usr/local/bin)
```

## 📜 License

MIT License - Free to use, modify, and share!

## ✨ Contributing

Pull requests are welcome! If you find a bug or want to improve the script, feel free to open an issue.

