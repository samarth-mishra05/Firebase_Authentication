# Firebase Authentication Project

This is a basic flutter authentication project integrated with firebase. This project features authentication screens for an app.
This project provides simple and intuitive interface for user registration, login, reset password and user database functionality.

## Features
- User registration with email and password.
- Secure user login using email and password.
- Password reset functionality.
- Firebase Google Sign-In integration.
- Displays user details (e.g., email) upon successful login.
- Logout functionality.

## Prerequisites
To run this project, ensure you have the following installed:

- Android Studio (Latest stable version)
- Flutter SDK
- Java/Kotlin Development Kit
- A Firebase account

## Installation
- Open the project in Android Studio.
- Build the project to download dependencies.
- Run the app on an emulator or physical device.

## Usage
- Registration: Navigate to the sign-up screen and enter your email and password to create a new account.
- Log In: Use your registered email and password to log in.
- Log Out: Click the logout button to sign out of your account.
- Reset Password: If you forget your password, you can reset it using the password reset functionality

## Technology Used
- Flutter - UI software development kit (SDK)
- Firebase Authentication: Handles user authentication.
- Android Studio: IDE for app development.
- Dart: Programming language used.

## Getting Started

Follow these steps to set up the project locally:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/samarth-mishra05/flutter_firebase_auth.git
   cd flutter_firebase_auth
   ```
2. **Install Dependencies:**
   
   Make sure you have Flutter and Dart SDK installed. Run the following command to get the required packages:
   
   ```bash
     flutter pub get
   ```
3. **Set up Firebase:**

   - Go to the [Firebase Console](https://console.firebase.google.com/)
   - Create a new project or select an existing one.
   - Add an Android app to your Firebase project.
   - Download the `google-services.json` file and place it in the `android/app/` directory of your Flutter project.
   - Enable Email/Password authentication in the Firebase Console under Authentication > Sign-in method.

4. **Configure Android project:**

   - Open `android/build.gradle` and add the Google services classpath in the dependencies section:
  
     
     ```groovy
     dependencies {
       classpath 'com.google.gms:google-services:4.3.10' // Check for the latest version
      }
      ```

   - Open `android/app/build.gradle` and apply the Google services plugin at the bottom of the file:

     ```groovy
        apply plugin: 'com.google.gms.google-services'
     ```

5. **Run the app:**

	You can now run the app using the following command: 

   ```bash
	   flutter run
	```
   
## Contributing

Contributions are always welcome!

Please follow these steps to contribute:

- Fork the repository.
- Create a new branch
  
  ```bash
    git checkout -b feature/YourFeature
  
  ```
- Make your changes and commit them

  ```bash
    git commit -m 'Add some feature'
  
  ```
- Push to the branch
  
  ```bash
    git push origin feature/YourFeature
  
  ```
- Open a pull request


## License

This project is licensed under the MIT License - see the [License](https://choosealicense.com/licenses/mit/) for details

## Acknowledgements

 - [Flutter](https://flutter.dev/)
 - [Firebase](https://firebase.google.com/)


