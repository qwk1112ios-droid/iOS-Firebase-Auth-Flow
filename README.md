# iOS Firebase Auth Flow (SwiftUI)

A production-ready authentication flow built with **SwiftUI** and **Firebase**, supporting multiple sign-in providers and handling real-world edge cases such as account linking and cross-device state consistency.

---

## Features

* Email / Password Authentication
* Google Sign-In
* Sign in with Apple (secure nonce handling)
* Anonymous authentication and account linking
* Firestore user profile creation & sync
* Authentication state management
* Robust error handling (Firebase Auth errors)
* Token refresh handling for multi-device scenarios

---

##  Architecture

This project follows a clean and scalable structure:

* **MVVM (Model-View-ViewModel)**
* **AuthManager** → handles authentication logic
* **FirestoreManager** → manages user data
* **AppSession** → global authentication state
* Modular feature-based folder structure

---

##  Edge Cases Handled

This project focuses on real-world scenarios often missed in tutorials:

* Account deleted from another device
* Cached authentication state inconsistencies
* Missing Firestore user document
* Credential conflicts during account linking
* Token invalidation and forced refresh

---

##  Tech Stack

* Swift
* SwiftUI
* Firebase Authentication
* Firestore
* Google Sign-In
* Sign in with Apple
* Swift Concurrency (async/await)

---

##  Setup

1. Clone the repository

```bash
git clone https://github.com/your-username/iOS-Firebase-Auth-Flow.git
```

2. Open the project in Xcode

3. Add your Firebase configuration file:

* Download `GoogleService-Info.plist` from Firebase Console
* Add it to the project (do NOT commit it)

4. Enable Authentication providers in Firebase Console:

* Email/Password
* Google
* Apple

5. Run the app 🚀

---

##  Important Notes

* `GoogleService-Info.plist` is intentionally ignored for security reasons
* Make sure to configure Firebase properly before running the project
* Apple Sign-In requires proper capability setup in Xcode

---

##  Screenshots

*Add screenshots here (Login, Sign Up, Home, etc.)*

---

##  Future Improvements

* Unit tests for AuthManager
* UI tests for authentication flow
* Profile management screen
* Error UI/UX improvements

---

## 👩🏻‍💻 Author

**Amel Sbaihi**
Senior iOS Engineer

---

## ⭐️ If you found this helpful

Give the repo a star ⭐️
