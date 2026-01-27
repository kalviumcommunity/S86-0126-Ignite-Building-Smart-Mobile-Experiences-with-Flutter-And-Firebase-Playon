# s86_0126_flutter_basics

A beginner-friendly Flutter project created to understand the fundamentals of Flutter application development and project structure.

This project focuses on learning how a Flutter app is organized, how different files and folders work together, and how to maintain a clean structure for scalable and maintainable development.

---

## Project Setup Overview

This Flutter project was created using the standard Flutter CLI command:

```bash
flutter create s86_0126_flutter_basics

Folder Structure Summary

The detailed explanation of each folder is documented in PROJECT_STRUCTURE.md.
Below is a brief overview of the main folders and files:

lib/
Contains the main Dart source code for the application. This is where the UI and business logic are written.

android/
Contains Android-specific configuration files and native code.

ios/
Contains iOS-specific configuration files and native code.

web/
Includes files required to run the application in a web browser.

test/
Used for writing unit tests and widget tests.

pubspec.yaml
Manages project dependencies, assets, and metadata.

For a detailed explanation, refer to PROJECT_STRUCTURE.md.

Folder Hierarchy (IDE View)

Below is an example of the project structure as seen in an IDE:

s86_0126_flutter_basics/
│
├── android/
├── ios/
├── lib/
│   └── main.dart
├── test/
├── web/
├── pubspec.yaml
├── README.md
└── PROJECT_STRUCTURE.md

Reflection
Why is it important to understand the role of each folder?

Understanding the purpose of each folder helps developers know where to write code, where configuration files belong, and how different platforms are managed within a single Flutter project. It reduces confusion, prevents accidental changes to critical files, and makes debugging and scaling the application easier.

How does a clean structure help when working in a team environment?

A clean project structure improves collaboration by making the codebase easier to understand for all team members. It helps new developers onboard faster, reduces merge conflicts, encourages consistent coding practices, and improves long-term maintainability of the project.

Resources

Flutter Codelab – Write your first app: https://docs.flutter.dev/get-started/codelab

Flutter Cookbook: https://docs.flutter.dev/cookbook

Flutter Documentation: https://docs.flutter.dev/

## Understanding Widget Tree & Reactive UI (Sprint #2)

### 📌 Description
This task demonstrates Flutter’s widget tree structure and its reactive UI model. A simple demo screen was created to show how widgets are arranged in a hierarchy and how the UI updates automatically when the state changes.

---

### 🌳 Widget Tree Hierarchy

Scaffold  
 ┣ AppBar  
 ┗ Body  
    ┗ Center  
       ┗ Column  
          ┣ Text  
          ┣ Container  
          ┗ ElevatedButton  

---

### 🔄 Reactive UI Model
Flutter uses a reactive UI approach. When the state changes using setState(), Flutter automatically rebuilds only the affected widgets instead of the whole screen. This makes UI updates fast and efficient.

In this demo:
- Initial UI shows default text and color
- Clicking the button updates the state
- Text and container color change instantly
- Only the required widgets are rebuilt

---

### 📸 Screenshots
- Initial UI state (before button click)
- Updated UI state (after button click)

---

### 🧠 Learning Outcome
Through this task, I understood how Flutter builds UI using a widget tree and how state changes trigger automatic UI updates. This helped me clearly understand Flutter’s reactive design pattern and efficient rendering system.