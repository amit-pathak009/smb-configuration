# **README.md**

````markdown
# smb-configuration

A complete SMB (Samba) configuration automation toolkit designed to simplify and accelerate the setup of SMB file sharing on Linux and Windows systems. This repository contains ready-to-use scripts for automated Samba configuration, Windows folder redirection, and streamlined network share preparation.

---

## 📌 Overview

Setting up SMB (Server Message Block) for file sharing can be confusing, especially when handling permissions, shares, registry edits, and cross-platform Windows + Linux environments.

This project provides:

- Automated SMB setup on Linux using shell scripts  
- Windows `.bat` script for file redirection  
- Windows `.reg` file for folder redirection  
- A pre-packaged setup useful for sysadmins, students, labs, and mixed-environment networks  

All files in this repository are standalone and ready to use without modifications.

---

## 📁 Repository Structure

| File | Description |
|------|-------------|
| **auto-smb-setup.sh** | Fully automated SMB setup script for Linux. Installs Samba, configures shares, sets permissions, and restarts services. |
| **smbconfig.sh** | Manual SMB configuration script offering step-by-step interactive controls. |
| **redirect-file.bat** | Windows batch script for redirecting files/folders to network shares. |
| **Redirect-folders.reg** | Windows registry file to configure folder redirection (e.g., Documents, Desktop) to SMB network locations. |
| **LICENSE** | Project license (GPL-3.0). |

---

## 🧩 Features

### ✔ Linux Features  
- Automatic Samba installation  
- Creation of shared directories  
- Permission and ownership configuration  
- Automatic Samba user configuration  
- Auto-generation of `smb.conf` entries  
- Samba service restart and validation  

### ✔ Windows Features  
- Folder redirection via registry  
- Batch script-based file/folder redirection  
- Plug-and-play compatibility with server SMB shares  

### ✔ General Benefits  
- Cross-platform SMB deployment  
- Eliminates manual configuration errors  
- Saves time when deploying on multiple machines  
- Ideal for labs, servers, classrooms, and enterprise environments  

---

## 🚀 Getting Started

### 🔧 Linux Setup (Automatic)

Run the following commands:

```bash
git clone https://github.com/amit-pathak009/smb-configuration.git
cd smb-configuration
sudo bash auto-smb-setup.sh
````

This script will:

1. Install Samba
2. Create shared directories
3. Apply permissions
4. Configure users
5. Append configuration to `/etc/samba/smb.conf`
6. Restart Samba services

You don't need to edit any file before running it.

---

### 🔧 Linux Setup (Manual / Interactive)

If you prefer manual step-by-step configuration:

```bash
sudo bash smbconfig.sh
```

This script allows you to:

* Add new SMB shares
* Edit permissions
* Configure Samba users
* Restart Samba safely

---

## 🪟 Windows Configuration

### ▶ Option 1: File/Folder Redirection (.bat)

Run:

```cmd
redirect-file.bat
```

This can redirect folders/files to SMB network paths, useful for user profile management or mapped drive automation.

---

### ▶ Option 2: Folder Redirection via Registry (.reg)

Double-click:

```
Redirect-folders.reg
```

This registry patch enables automatic folder redirection to SMB shares such as:

* Documents
* Desktop
* Downloads
* Pictures

⚠ **Important:** Always back up your registry before applying `.reg` files.

---

## 🧠 How It Works — Explanation

### 🔹 Samba (SMB) on Linux

The scripts automate:

* Installation of `samba` and related packages
* Creating directories under `/srv/samba/`
* Setting ownership (`chown`) and permissions (`chmod`)
* Backing up existing Samba config
* Appending new share blocks to `smb.conf`
* Creating Samba users (`smbpasswd -a`)
* Restarting Samba with:

  ```bash
  systemctl restart smbd nmbd
  ```

### 🔹 Windows Side

The `.reg` and `.bat` files help link user environment folders to the SMB share so that:

* Files are stored on the server
* Backups become centralized
* Multi-PC usage is supported seamlessly

---

## 🧪 Example SMB Share Block

The automated setup script generates entries like:

```ini
[shared]
   path = /srv/samba/shared
   browseable = yes
   read only = no
   writable = yes
   valid users = @users
   create mask = 0775
   directory mask = 0775
```
