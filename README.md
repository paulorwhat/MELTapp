# MELT (Military Expense Logging Tool)

**MELT** is an iOS application that enables you to log, organise, and manage military-related expense receipts. 
This version stores data locally using JSON rather than Core Data, allowing for a simpler and more portable system. 
Users can create folders containing receipts, attach photos, pick custom dates, delete items, and toggle between light and dark modes.

---

## Table of Contents
1. [Overview](#overview)  
2. [Key Features](#key-features)  
3. [Requirements](#requirements)  
4. [Installation](#installation)  
5. [Usage](#usage)  
6. [File Structure](#file-structure)  
7. [App Icon](#app-icon)  
8. [Future Improvements](#future-improvements)  
9. [Licence](#licence)

---

## Overview
MELT is designed to help service personnel easily record expenses, optionally attach photos for proof, 
and keep a running total of all claims in a straightforward interface.

### Technology Stack
- **SwiftUI** for the front-end user interface  
- **JSON** for data persistence  
- **Xcode** (14.0+) as the main IDE  

---

## Key Features
1. **Account Management**  
   - Create or log into an account using just a username (demo only; no password security).  
   - Toggle **dark mode** in the user’s profile—this reflects across the entire app interface.

2. **Folders for Receipts**  
   - Create multiple folders to organise different expense categories.  
   - Each folder displays a **running total** of its receipts.

3. **Receipts**  
   - **Add a receipt** with amount, description, optional photo, and a user-chosen date (defaulting to now).  
   - **Delete** receipts if they are no longer needed, using either swipe-to-delete or the Delete button in the detail screen.

4. **Military Colour Theme**  
   - Uses a **military-inspired green** accent and subtle backgrounds for a cohesive aesthetic.
   - Light or dark mode can be toggled from the profile screen.

---

## Requirements
- **iOS 15.0** or later  
- **Xcode 14** or later  
- **Swift 5.5** or later  
- Optional: **Camera** permission if you wish to capture receipt photos on a real device  

---

## Installation
1. **Clone or Download** this repository.  
2. **Open** the `.xcodeproj` or `.xcworkspace` in Xcode.  
3. **Build and Run** on either a simulator or a physical device.  
   - If testing the camera, a physical device is recommended.

---

## Usage
1. **Launch the App**  
   - You will see the **Landing Screen** featuring a military-esque logo, plus “Log In” and “Create Account” options.

2. **Create Account or Log In**  
   - Enter a username. (Passwords are not enforced in this demonstration.)

3. **Folders Screen**  
   - Create folders to categorise different expense types.  
   - Tap a folder to view its receipts and total amount.

4. **Receipts**  
   - Use “Add Receipt” to input the amount, description, optional photo, and date.  
   - Tap a receipt to see its detailed view, or swipe left to delete it.  
   - A **Delete** button in the detail screen also lets you remove a receipt explicitly.

5. **Profile**  
   - Access your user profile via the person icon on the Folders screen.  
   - Toggle **dark mode** on/off and see the theme update instantly.  
   - **Log Out** returns you to the landing screen.

All data is stored in `Documents/MELTData.json` on the device, so your changes will persist between launches.

---

## App Icon
The app uses a **custom icon** reflecting a military/camera/finance theme. A base64-encoded placeholder is provided in the project;
after decoding and placing it into **Assets.xcassets** → **AppIcon**, you can assign it as the app’s icon.
Feel free to design or replace with a more refined asset.

---

## Future Improvements
- **Proper Authentication**  
  - Implement secure username/password or Single Sign-On for real-world usage.  

- **iCloud Sync**  
  - Sync JSON data to iCloud or another service, so receipts are available across multiple devices.  

- **PDF/CSV Exports**  
  - Export a folder’s receipts as a spreadsheet or PDF for official reimbursements.  

- **Enhanced Image Handling**  
  - Compress or store images externally if large photos become a performance concern.

---

## Licence
This sample application is provided **as-is** for demonstration purposes.
You are free to modify or adapt the code for your own projects. Use in production at your own risk.

---

**Enjoy using MELT!** If you have any queries, suggestions, or encounter issues,
please open a GitHub issue or submit a pull request.

---

## File Structure

```plaintext
MELT/
 ├─ Models/
 │   ├─ User.swift           # Stores user data (username, darkMode, folders)
 │   ├─ Folder.swift         # Contains folder name & array of receipts
 │   └─ Receipt.swift        # Data for each receipt (amount, date, optional photo)
 │
 ├─ PersistenceManager.swift # Handles reading/writing JSON to MELTData.json
 ├─ AppViewModel.swift       # Global state for users, login, toggling dark mode
 │
 ├─ MELTApp.swift            # Main entry point, sets up RootView & dark/light mode
 │
 ├─ Views/
 │   ├─ RootView.swift       # Decides whether to show the Landing or main content
 │   ├─ LandingView.swift    # Shows the app logo & Log In / Create Account
 │   ├─ LoginView.swift      # Basic login form (username only)
 │   ├─ CreateAccountView.swift
 │   ├─ MainContentView.swift
 │   ├─ ProfileView.swift    # Dark mode toggle & logout
 │   ├─ FolderListView.swift # Shows all folders & add/delete folder
 │   ├─ AddFolderView.swift  # Form to name a new folder
 │   ├─ FolderDetailView.swift
 │   │   ├─ AddReceiptView.swift   # Enter receipt details, pick date & photo
 │   │   ├─ ReceiptDetailView.swift
 │   │   └─ ReceiptRowView.swift
 │
 ├─ ImagePicker.swift        # Reusable view for camera or photo library
 │
 └─ Assets.xcassets
     ├─ AppIcon.appiconset/   # Place your app icon images here
     ├─ ArmyGreen.colorset/   # Colour asset for the military green theme
     └─ (other images/logos)

