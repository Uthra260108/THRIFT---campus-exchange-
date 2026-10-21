# thrift — The Campus Exchange

A complete, runnable, database-connected desktop application for college students to sell, donate, exchange, and request used academic materials and campus essentials.

Built with **Java Swing**, **AWT**, **JDBC**, and **MySQL 8.0**.

---

## 1. Project Overview & Features

- **Application Name**: `thrift`
- **Visual Identity**: Inspired by the modern college thrift exchange aesthetic with editorial Rose (`#7B1E3A`), Blush (`#F0D9E4`), Raspberry (`#A83258`), Cream (`#FFF5F7`), and Gold accents.
- **Student Authentication**:
  - **Signup**: Student name, college registration number, email, department, year of study, phone, and securely hashed passwords using **PBKDF2-HMAC-SHA256**.
  - **Login**: Login with either **Registration Number** or **Email Address**.
  - **Duplicate prevention**: Real database checks prevent duplicate registration numbers and emails.
- **Marketplace**:
  - Real-time catalog of available academic materials (Books, Electronics, Lab Equipment, Study Kits, Stationery, Clothing, etc.).
  - Search by item name or keywords.
  - Category filtering and listing type filtering (**SELL**, **DONATE**, **EXCHANGE**).
  - Price sorting (Low to High, High to Low, Newest).
  - Item detail modal with seller information.
- **Add Item**:
  - Complete form to publish items for sale, donation, or exchange.
  - Automatically associates listings with the logged-in student.
  - Validates prices for sale listings (must be positive) and auto-handles free items.
- **My Listings**:
  - Displays all items published by the current student.
  - Edit item details.
  - Update availability status (**AVAILABLE**, **RESERVED**, **SOLD**, **DONATED**).
  - Delete own listings safely.
  - Strict security prevents modifying other students' items.
- **Item Requests**:
  - Request available items from peers (prevents self-requests and duplicate active requests).
  - **Sent Requests**: Track status of your inquiries (**PENDING**, **APPROVED**, **REJECTED**, **COMPLETED**).
  - **Incoming Requests**: Accept/Reserve items or Decline requests in database transactions. Mark items as completed when handed over.
- **Profile Management**:
  - View and update student contact details (department, year, phone, name).

---

## 2. Technology Stack

- **Language**: Java 17+ (tested on Java 27)
- **GUI**: Java Swing & AWT (with optional FlatLaf theme for high DPI scaling)
- **Database Connectivity**: JDBC (`mysql-connector-j-8.3.0.jar`)
- **Database Engine**: MySQL Server 8.0
- **Security**: Cryptographic password hashing (PBKDF2-HMAC-SHA256 with 65,536 iterations and random 16-byte salt)
- **Architecture**: Model-View-DAO-Service pattern

---

## 3. Database Configuration

The application connects to MySQL on `localhost:3306` with database `campus_thrift`.

Credentials are configured in `db.properties` at the root of the project:

```properties
db.url=jdbc:mysql://localhost:3306/campus_thrift?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
db.user=root
db.password=UTHRA@2008
db.driver=com.mysql.cj.jdbc.Driver
```

> **Note**: If your MySQL password or port differs, simply edit `db.properties`.

### Automatic Database Setup
On first launch, `DatabaseInitializer` automatically creates:
1. The `campus_thrift` database if it does not already exist.
2. The `users`, `items`, and `item_requests` tables.
3. Pre-seeded demo student accounts and sample college listings.

### Manual Database Setup (Alternative via MySQL Workbench)
If you prefer to run the SQL script manually:
1. Open **MySQL Workbench**.
2. Connect to your local MySQL instance.
3. Open the file `sql/campus_thrift.sql`.
4. Click the lightning bolt icon (Execute).

---

## 4. How to Compile and Run

You can run `thrift` either as a **Desktop Application (Java Swing)** or as a **Web Application (Browser)**!

### Option A: Web Application (Browser & Mobile Access)
1. **Launch Web Server**: Double-click or run `run-web.bat`:
   ```cmd
   run-web.bat
   ```
2. **Open in Browser**:
   - On your laptop: Open **http://localhost:8080**
   - On phones or other devices on your Wi-Fi: Open **http://<your-ip>:8080**

### Option B: Desktop GUI Application (Java Swing)
1. **Compile**:
   ```cmd
   compile.bat
   ```
2. **Run Desktop App**:
   ```cmd
   run.bat
   ```
3. **Run Automated Test Suite**:
   ```cmd
   test.bat
   ```

---

## 5. Cloud Deployment Guide (Sharing with Anyone Online)

To give everyone a public link (e.g. `https://campus-thrift.onrender.com`):

1. **Host MySQL Online (Free)**:
   - Create a free MySQL database on [Aiven.io](https://aiven.io), [Clever Cloud](https://www.clever-cloud.com/), or [Railway](https://railway.app).
   - Get the connection URL and credentials.
2. **Deploy to Render.com (Free)**:
   - Push this repository to GitHub.
   - Go to [Render.com](https://render.com) -> New -> **Web Service**.
   - Connect your GitHub repository (it will automatically use the included `Dockerfile` and `render.yaml`).
   - Add environment variables in Render:
     - `DB_URL`: `jdbc:mysql://<cloud-host>:3306/<cloud-db>?useSSL=true`
     - `DB_USER`: `<cloud-user>`
     - `DB_PASSWORD`: `<cloud-password>`
   - Click **Deploy**! Render builds the app and gives you a live `https://...` link.

---

## 5. Demo Student Accounts & Credentials

The database comes pre-populated with demo college student accounts for immediate testing:

| Student Name | Registration No | Email Address | Password | Department |
|---|---|---|---|---|
| **Aadhya Raman** | `2025501042` | `aadhya.raman@campus.edu` | `student123` | ECE |
| **Ishaan Kumar** | `2025502186` | `ishaan.k@campus.edu` | `student123` | CSE |
| **Meera S.** | `2025503077` | `meera.s@campus.edu` | `student123` | Mathematics |
| **Kavin Raj** | `2025500916` | `kavin.r@campus.edu` | `student123` | Mechanical |

*You can also create any brand new account by switching to the **Create Account** tab!*

---

## 6. Pre-Seeded Sample Listings

1. **Engineering Drawing Kit** — ₹300.00 (Study Materials, Sell)
2. **Scientific Calculator (Casio fx-991EX)** — ₹450.00 (Electronics, Sell)
3. **Lab Coat — Clean & Freshly Washed** — FREE (Lab Equipment, Donate)
4. **DSA in Java — Textbook & Problem Sets** — ₹280.00 (Books, Sell)
5. **Java: The Complete Reference (12th Ed)** — EXCHANGE (Books, Exchange)
6. **Record Notebook & Mechanics Study Notes** — FREE (Stationery, Donate)
7. **Warm LED Desk Lamp in Blush Pink** — ₹350.00 (Other, Sell)

---

## 7. Project Structure

```
PROJECT JAVA/
├── lib/
│   ├── mysql-connector-j-8.3.0.jar   (MySQL JDBC Driver)
│   └── flatlaf-3.4.1.jar             (Modern Swing Look & Feel)
├── sql/
│   └── campus_thrift.sql             (Complete MySQL schema & seed script)
├── src/
│   └── main/
│       ├── java/
│       │   ├── Main.java             (Application Main Entry Point)
│       │   ├── AppTest.java          (End-to-End Automated Test Runner)
│       │   ├── database/
│       │   │   ├── DatabaseConfig.java
│       │   │   ├── DatabaseConnection.java
│       │   │   └── DatabaseInitializer.java
│       │   ├── model/
│       │   │   ├── User.java
│       │   │   ├── Item.java
│       │   │   └── ItemRequest.java
│       │   ├── dao/
│       │   │   ├── UserDAO.java
│       │   │   ├── ItemDAO.java
│       │   │   └── ItemRequestDAO.java
│       │   ├── service/
│       │   │   ├── AuthenticationService.java
│       │   │   ├── ItemService.java
│       │   │   └── RequestService.java
│       │   ├── util/
│       │   │   ├── PasswordUtil.java
│       │   │   └── ValidationUtil.java
│       │   └── ui/
│       │       ├── UITheme.java
│       │       ├── AuthFrame.java
│       │       ├── MainFrame.java
│       │       ├── HomePanel.java
│       │       ├── MarketplacePanel.java
│       │       ├── AddItemPanel.java
│       │       ├── MyListingsPanel.java
│       │       ├── MyRequestsPanel.java
│       │       ├── ProfilePanel.java
│       │       └── ItemDetailDialog.java
│       └── resources/
│           └── db.properties
├── compile.bat                       (One-click Windows build script)
├── run.bat                           (One-click Windows launch script)
├── test.bat                          (One-click automated test script)
├── pom.xml                           (Maven dependency management configuration)
├── db.properties                     (Root database configuration)
└── README.md                         (Documentation)
```
