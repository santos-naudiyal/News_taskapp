# News App - User Guide

Welcome to the **News App**! This is a simple application that lets you read the latest news from around the world on your phone.

## How to Run the App

Follow these simple steps to get the app running on your computer.

### What You Need
Before you start, make sure you have these installed:
1.  **Flutter SDK** (Version 3.32.0)
2.  **Java SDK** (Version 24.0.1 2025-04-15)
3.  An Android Emulator or a real Android phone connected to your computer.

### Steps to Start
1.  **Open the Project**: Open the folder where this app is saved (likely `s:\task news app\News_taskapp`) in your code editor (like VS Code or Android Studio).
2.  **Get Ready**: Open the "Terminal" (a command window inside your editor) and type this command:
    ```bash
    flutter pub get
    ```
    (This downloads all the necessary tools for the app).
3.  **Run**: Make sure your phone/emulator is connected, then type:
    ```bash
    flutter run
    ```
    The app should open on your device after a minute or two.

---

## What Can You Do? (Features)

Here is a quick tour of what you can do in the app:

### 1. 📰 Read the News
When you open the app, you will see a list of news articles. You can scroll down to see more.
-   **Categories**: Look for tabs or a menu to switch topics (like "Sports", "Technology", "Business").

### 2. 📖 Read Full Articles
Tap on any news card to open the **Article Screen**.
-   Here you can see the full image and read the detailed story.

### 3. 🔖 Save for Later (Bookmarks)
Found something interesting but don't have time?
-   Tap the **Bookmark Icon** (usually looks like a ribbon) on any article.
-   The article will be saved to your "Saved" or "Bookmarks" list so you can find it later easily.

### 4. 🔍 Search
Looking for something specific?
-   Use the **Search Bar** at the top of the home screen.
-   Type in a keyword (e.g., "Bitcoin", "Football") to find related articles.

### 5. 📤 Share
Want to show a friend?
-   Tap the **Share** button to send the article link to others via WhatsApp, Email, or other apps.

---

## Improvements & Technical Details

We built this app using **Flutter**, which makes it fast and smooth.
-   **Clean Design**: We used a "Clean Architecture" pattern to keep the code organized.
-   **Reliable**: We use "BLoC" (Business Logic Component) to handle how the app works behind the scenes, ensuring it doesn't crash easily.
