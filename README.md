# ExpenseTracker

Simple expense tracker app for Unicode's Event **Hackprep 7.0**

## 💡 What it does

- **Expense Tracking**: Easily log your daily expenses with details like name, cost, and description.
- **Full CRUD Support**: Create, Read, Update, and Delete expenses seamlessly.
- **Real-time Sync**: Frontend and Backend integration via RESTful APIs.
- **Mobile-First Design**: A clean and responsive user interface built with Flutter.

## 🛠️ Tech Stacks

- **Backend**: `Django`
- **Frontend**: `Flutter`

## 🚀 How to run it locally

### 1. Clone the repo

```bash
git clone https://github.com/SudevOP1/ExpenseTracker.git
cd ExpenseTracker
```

### 2. Backend Server

One time setup:

```powershell
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

Starting server:

```powershell
cd backend
python manage.py makemigrations
python manage.py migrate
python manage.py runserver
```

### 3. Frontend App (Flutter)

One time setup:

```powershell
cd xpense
flutter pub get
```

Running the app:

```powershell
flutter run
```

## 📁 Project Structure

```text
ExpenseTracker/
├── backend/            # Django project root
│   ├── appname/        # Expense tracking app logic
│   └── backend/        # Project configuration
├── xpense/             # Flutter project root
│   ├── lib/            # Dart source code
│   └── pubspec.yaml    # Flutter dependencies
└── requirements.txt    # Python dependencies
```

## 🔌 API Endpoints

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/appname/get-expenses/` | Fetch all expenses |
| `POST` | `/appname/create-expense/` | Add a new expense |
| `PUT` | `/appname/update-expense/` | Edit an existing expense |
| `DELETE` | `/appname/delete-expense/` | Delete an expense |

## ⚠️ Troubleshooting

- **Localhost Connection**: If running on a **physical device**, ensure both your PC and phone are on the same network. Update the `baseUrl` in `lib/main.dart` from `127.0.0.1` to your PC's local IP address (e.g., `192.168.x.x`).
- **Database Migrations**: If you see a "no such table" error, ensure you have run the migrations in the backend section.
- **Port Busy**: The Django server runs on port `8000` by default. Ensure no other service is using it.
