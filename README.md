<img width="373" height="791" alt="cart_ss" src="https://github.com/user-attachments/assets/470e4aaa-aa1b-4fb2-b2a4-44d713a332a2" /># BiteDash - A Modern Canteen Ordering App 🍔

*A feature-rich Flutter MVP designed to streamline canteen ordering, featuring categorized menus, real-time search, and a complete shopping cart system.*

---

### 🎬 App Screenshots & Demo

| Menu & Search | Item Detail Page | Cart Page |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/fc9bff29-878a-4171-a01a-3f63a1454ac1" width="250" /> | <img src="https://github.com/user-attachments/assets/5807574e-9fd2-4309-8ed2-198e89b3f32d" width="250" /> | <img width="373" height="791" alt="cart_ss" src="https://github.com/user-attachments/assets/2364863e-2843-4aea-8a9a-c4ccecfa9159" />
 |

---

### 🎯 The Problem

In many college canteens, students face long queues and significant wait times, especially during peak hours. This leads to a chaotic and inefficient ordering process. **BiteDash** is a Minimum Viable Product (MVP) designed to solve this by providing a simple, modern, and digital ordering platform.

---

### ✨ Features

* **Dynamic Menu with Categories:** Fetches data from a REST API and displays it in logical categories (e.g., "Snacks," "Main Course").
* **Real-time Search:** Instantly filter menu items by name with a responsive search bar.
* **Detailed Product View:** Tap on any item to see a dedicated page with a larger image, description, and rating, using a `Hero` animation for a smooth transition.
* **Stateful Shopping Cart:** A fully functional cart system that allows users to add and remove items. The cart state is managed globally using the Provider package.
* **Real-time Cart Badge:** The cart icon in the app bar updates instantly with a badge showing the current number of items.
* **REST API Integration:** Built against a mock API, demonstrating a professional workflow where the frontend can be developed independently of the backend.

---

### 🛠️ Tech Stack & Architecture

* **Framework:** Flutter
* **Language:** Dart
* **Architecture:** Follows a clear, scalable structure with Separation of Concerns.
    * **State Management:** `Provider` (for managing menu, search, and cart state).
    * **API Calls:** `http` package.
    * **UI:** `badges` package for the cart icon.
* **Project Structure:** The codebase is organized into logical directories:
    * `models`: Contains the data structure for a menu item.
    * `providers`: Holds all the business logic and state management.
    * `screens`: Contains the main pages of the app (Menu, Details, Cart).
    * `widgets`: Contains reusable UI components (e.g., the menu item card).

---

### 🚀 Future Enhancements

This project is a solid foundation, and the next steps are planned to make it a full-stack application:

* **Firebase Backend Integration:** Replace the mock API with a live Firebase backend using Cloud Firestore for the database and Firebase Authentication for secure user login.
* **Admin Panel:** A separate web or mobile interface for canteen staff to manage menu items, prices, and availability in real-time.
* **Payment Gateway Integration:** Integrate a secure payment provider like Stripe or Razorpay to handle online transactions.
