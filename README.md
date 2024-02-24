# Krishi Sankalp
This Flutter app was my team named 'Adbhut', final project for GDSC 2023's Solutions Challenge. Its main feature is a tensorflow model which detects which disease a crop has based on its affected leaves. It has Firebase connectivity and uses Firestore Database for storing user and disease information.

# Presentation


# Installation
Follow the setup guide in flutter's documentation [here](https://docs.flutter.dev/get-started/install). Android Studio or VS Code are the preferred environment.

Download the project

`git clone https://github.com/LakshyaSharma207/KrishiSankalp-gdsc-solutions.git`

Inside of the project directory run below command in terminal

`flutter pub get`

#### For testing the app using your own Firebase project
First download [Firebase tools](https://firebase.google.com/docs/cli/#install_the_firebase_cli) in your cli and login.

Using [flutterfire](https://firebase.google.com/docs/flutter/setup?platform=android) generate your own configure file with your private apis and keys.

Then to run the project (in android emulator)

`flutter run`

Note: Since its an andorid application the test build can also run in physical devices with enabled devloper settings and usb debugging 'on'.
