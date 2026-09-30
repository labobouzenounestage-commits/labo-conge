-- Création de la base de données
CREATE DATABASE IF NOT EXISTS leave_management_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE leave_management_db;

-- Table des utilisateurs
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Manager', 'Employé') DEFAULT 'Employé',
    annual_balance INT DEFAULT 30,
    sick_balance INT DEFAULT 15,
    rtt_balance INT DEFAULT 5,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des demandes de congé
CREATE TABLE IF NOT EXISTS leave_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    leave_type ENUM('سنوية', 'مرضية', 'استرجاع') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    days_count INT NOT NULL,
    reason TEXT,
    substitute_id INT DEFAULT NULL,
    status ENUM('PendingSubstitute', 'PendingManager', 'RejectedSubstitute', 'Approved', 'Rejected') DEFAULT 'PendingSubstitute',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (substitute_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Table des notifications
CREATE TABLE IF NOT EXISTS notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    target_user_id INT DEFAULT NULL,
    target_role VARCHAR(50) DEFAULT NULL,
    message_ar TEXT NOT NULL,
    message_fr TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (target_user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Insertion des utilisateurs par défaut (mots de passe en clair pour l'exemple)
INSERT INTO users (first_name, last_name, username, email, password, role, annual_balance, sick_balance, rtt_balance) VALUES
('Nadir', '(Admin)', 'nadir', 'nadir@company.com', 'nadir@1990', 'Admin', 30, 15, 5),
('Admin', '(Manager)', 'admin', 'admin@company.com', 'admin@123', 'Manager', 30, 15, 5),
('Ahmed', 'Employeur', 'ahmed', 'ahmed@company.com', '123', 'Employé', 25, 10, 3);