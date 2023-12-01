# Development-of-a-Login-and-Logout-System-for-BSU-Lipa-Library

## Introduction
This project aims to improve library management capabilities and simplify library access for BSU-Lipa students by developing a QR code-based login and logout system and offering separate user roles with specific features.

## User Roles and Functionalities
### Student:
* Login and logout using QR codes
* View personal library records

### Employee:
* View and track library records
* Manage system settings
* Search students

### Admin:
* Create accounts for employees
* View and track all library records
* Manage system settings
* Search students

## Technologies Used
The project utilizes PHP as the primary programming language and the database is run using PHPMyAdmin within XAMPP.

# Project Setup
### 1. Clone the Repository:
Open your terminal or command prompt and navigate to the desired location where you want to store the project files. Then, use the following command to clone the project repository:
git clone https://github.com/RicaAngel/Development-of-a-Login-and-Logout-System-for-BSU-Lipa-Library.git

### 2. Set Up XAMPP with PHPMyAdmin:
Download and install XAMPP, a complete web development environment that includes Apache, MySQL, PHP, and PHPMyAdmin. Ensure that Apache and MySQL are running properly in your XAMPP server.

<img width="494" alt="Screenshot 2023-12-01 112946" src="https://github.com/RicaAngel/Development-of-a-Login-and-Logout-System-for-BSU-Lipa-Library/assets/145759124/ef086f01-824a-435c-b16e-6a01d912dc26">

### 3. Create Database:
Open PHPMyAdmin in your web browser. Click on the "Databases" tab and create a new database named "db_nt3102".

<img width="440" alt="Screenshot 2023-12-01 113311" src="https://github.com/RicaAngel/Development-of-a-Login-and-Logout-System-for-BSU-Lipa-Library/assets/145759124/26032e55-844f-4db7-a7db-8cae7c2259b3">

### 4. Import Database:
Locate the "database" folder within the cloned project directory. Extract the SQL file from the database folder and import it into the newly created "db_nt3102" database in PHPMyAdmin.

<img width="775" alt="Screenshot 2023-12-01 113546" src="https://github.com/RicaAngel/Development-of-a-Login-and-Logout-System-for-BSU-Lipa-Library/assets/145759124/8c72ffc4-3549-4f3a-aed9-9f4787fa88f3">

### 5. Place Project Files:
Navigate to the "htdocs" folder within your XAMPP installation directory. Copy the entire contents of the cloned project directory into the "htdocs" folder.

<img width="450" alt="Screenshot 2023-12-01 113731" src="https://github.com/RicaAngel/Development-of-a-Login-and-Logout-System-for-BSU-Lipa-Library/assets/145759124/1273a571-e11b-4096-8662-3338cc58e8de">

### 6. Access Project:
Open your web browser and type the following URLs to access the respective interfaces:

* Student Login and Logout: [localhost/BSU-Library-Login-Logout]
* Admin and Employee Login and Logout: [localhost/BSU-Library-Login-Logout/admin]

Ensure that Apache and MySQL are running in your XAMPP server before accessing these URLs.

## Group Members:
* Barleta, Rica Angel A.
* Estor, Jed Khan M.
* Igle, Mikko D.
* Plata, Janna Pearlene J.
* Reyes, Christian Jay B.
