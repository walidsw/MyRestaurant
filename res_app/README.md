# Project Title: Restaurant App

## Description
This is a Flutter-based restaurant application that allows users to browse the menu, add items to their cart, and proceed to checkout. The app features a user-friendly interface and provides functionalities for user authentication, order management, and profile management.

## Features
- **Splash Screen**: Displays a splash screen when the app is launched.
- **Home Screen**: Main screen displaying categories and menu items.
- **Menu Screen**: Lists all available menu items.
- **Item Detail Screen**: Shows details of a selected menu item.
- **Cart Screen**: Displays items in the user's cart with options to modify quantities.
- **Checkout Screen**: Allows users to review their order and enter payment information.
- **Order Confirmation Screen**: Displays a confirmation message after an order is placed.
- **Profile Screen**: Enables users to view and edit their profile information.
- **Login Screen**: Allows users to log in to their account.

## Models
- **MenuItem**: Represents a menu item with properties such as id, name, description, price, image, category, rating, reviews, and isVeg.
- **CartItem**: Represents an item in the cart, containing a MenuItem and a quantity.
- **Order**: Represents an order with properties such as orderId, cartItems, totalAmount, and orderDate.
- **User**: Represents a user with properties such as id, name, email, and password.

## Widgets
- **CategoryChip**: Represents a category in a chip format.
- **MenuItemCard**: Displays a menu item in a card format.
- **CartItemWidget**: Displays an item in the cart.
- **CustomAppBar**: Provides a consistent app bar across screens.
- **CustomButton**: Provides a reusable button style.

## Services
- **ApiService**: Handles API requests and responses.
- **AuthService**: Manages user authentication.
- **CartService**: Manages cart operations.

## Providers
- **CartProvider**: Uses ChangeNotifier to manage cart state.
- **MenuProvider**: Uses ChangeNotifier to manage menu state.
- **AuthProvider**: Uses ChangeNotifier to manage authentication state.

## Utilities
- **Constants**: Contains constants used throughout the app, such as color values and text styles.
- **Routes**: Defines named routes for navigation.
- **Theme**: Defines the app's theme and styling.

## Assets
- **Images**: Contains image assets used in the app.
- **Fonts**: Contains font assets used in the app.

## Setup Instructions
1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Use `flutter run` to start the application.

## Usage
- Launch the app to view the splash screen.
- Navigate through the app to explore menu items, add them to the cart, and proceed to checkout.
- Users can log in to manage their profiles and view order history.

## License
This project is licensed under the MIT License.