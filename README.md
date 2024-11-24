# Internal Wallet App
The Internal Wallet App is a Ruby on Rails API application that allows users to manage wallets, perform transactions, and interact with stock prices. The application includes authentication using JWT tokens and provides endpoints for both admin and regular users.

# Table of Contents
- Features
- Getting Started
    - Prerequisites
    - Installation
    - Environment Setup
    - Database Setup
- Running the Application
- API Endpoints
    - Authentication
    - User Management (Admin)
    - Wallet Management
    - Stock Operations
    - Transactions
- Testing with Postman

# Features
- User Authentication: Secure login using JWT tokens.
- Admin Functions: Admins can create users, update wallets, and manage teams.
- Wallet Management: Users have wallets to manage their balance.
- Stock Integration: Fetch latest stock prices from an external API and purchase stocks.
- Transactions: Support for credits, debits, and transfers between wallets.

# Getting Started
- Prerequisites
- Ruby: Version 3.x
- Rails: Version 7.x
- PostgreSQL: For database management
- Bundler: To manage gem dependencies
# Installation
- Clone the Repository


```
git clone https://github.com/priyoiyo/internal_wallet_app.git
cd internal_wallet_app
```
- Install Dependencies

```
bundle install
```
# Database Setup
- Configure Database
Update the config/database.yml file with your PostgreSQL credentials.

- Create and Migrate Database
```
rails db:create
rails db:migrate
```
- Seed the Database (Optional)
```
rails db:seed
```
# Running the Application
Start the Rails server:
```
rails server
```
The application will run at http://localhost:3000.

# API Endpoints
## Authentication
### Sign In
- Endpoint: POST /sign_in
- Headers: Content-Type: application/json
- Request Body:
```
{
  "email": "user@example.com",
  "password": "password123"
}
```
- Response:
```
{
  "token": "your_jwt_token",
  "message": "Signed in successfully"
}
```
### Sign Out
- Endpoint: DELETE /sign_out
- Headers: Authorization: Bearer your_jwt_token
- Response:
```
{
  "message": "Signed out successfully"
}
```
## User Management (Admin)
### Create User
- Endpoint: POST /admin/users
- Headers:
    - Content-Type: application/json
    - Authorization: Bearer admin_jwt_token
- Request Body:
```
{
  "user": {
    "email": "employee@example.com",
    "password": "password123",
    "password_confirmation": "password123",
    "role": "employee",
    "team_id": 1
  }
}
```
- Response:
```
{
  "user": {
    "id": 3,
    "email": "employee@example.com",
    "role": "employee",
    "team_id": 1
  }
}
```
### Update User
- Endpoint: PUT /admin/users/:id
- Headers:
    - Content-Type: application/json
    - Authorization: Bearer admin_jwt_token
- Request Body:
```
{
  "user": {
    "email": "newemail@example.com",
    "role": "employee"
  }
}
```
- Response:
```
{
  "user": {
    "id": 3,
    "email": "newemail@example.com",
    "role": "employee",
    "team_id": 1
  }
}

```
## Wallet Management
### Update User Wallet (Admin)
- Endpoint: PATCH /admin/user_wallets/:user_id
- Headers:
    - Content-Type: application/json
    - Authorization: Bearer admin_jwt_token
- Request Body:
```
{
  "amount": 500.00
}
```
- Response:

```
{
  "wallet": {
    "id": 2,
    "user_id": 2,
    "balance": 1500.00
  }
}
```
## Stock Operations
### Get All Stock Prices
- Endpoint: GET /stocks/price_all
- Headers:
    - Content-Type: application/json
    - Authorization: Bearer your_jwt_token
- Response:
Returns a list of stock prices fetched from the external API.

### Buy Stock
- Endpoint: POST /stocks
- Headers:
    - Content-Type: application/json
    - Authorization: Bearer your_jwt_token
- Request Body:
```
{
  "symbol": "BAJFINANCE",
  "quantity": 2
}
```
- Response:
```
{
  "message": "Stock purchased successfully",
  "balance": 9000.00
}
```
## Transactions
### Create Transaction
- Endpoint: POST /transactions
- Headers:
    - Content-Type: application/json
    - Authorization: Bearer your_jwt_token
- Request Body:

```
{
  "type": "Transfer",
  "amount": 100.00,
  "target_user_id": 3
}
```
- Response:
```
{
  "message": "Transaction successful",
  "transaction": {
    "id": 5,
    "type": "Transfer",
    "amount": 100.00,
    "source_user_id": 2,
    "target_user_id": 3
  }
}
```
## Profile
### Get User Profile
- Endpoint: GET /profile
- Headers:
    - Authorization: Bearer your_jwt_token
- Response:
```
{
  "user": {
    "id": 2,
    "email": "user@example.com",
    "role": "employee",
    "team_id": 1
  },
  "wallet": {
    "id": 2,
    "balance": 9000.00
  }
}
```
# Testing with Postman
A Postman collection is provided to test the API endpoints. You can import the collection into Postman and use it to interact with the API.

- Import Collection
    - Open Postman.
    - Click on Import.
    - Choose the internal_wallet_app.postman_collection.json file provided.
- Set Environment Variables

    - Create a new environment in Postman.
    - Add the following variables:
        - base_url: http://localhost:3000
        - jwt_token: Your JWT token after signing in.
- Using the Collection

    - The collection includes requests for all API endpoints.
    - Make sure to replace placeholder values with actual data (e.g., your_jwt_token).
# License
This project is licensed under the MIT License. See the LICENSE file for details.
