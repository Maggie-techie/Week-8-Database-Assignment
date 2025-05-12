-- Clinic Booking System Database

CREATE DATABASE clinic_db;
USE clinic_db;

-- Table: Patients
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    birth_date DATE,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Table: Doctors
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Table: Appointments
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason VARCHAR(255),
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Table: Treatments
CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT NOT NULL,
    description VARCHAR(255) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Table: Payments
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT NOW(),
    method ENUM('Cash', 'Card', 'Insurance') NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);


-- Table: Doctor_Shifts (A doctor can have multiple shifts, and a shift can have multiple doctors)
CREATE TABLE Shifts (
    shift_id INT PRIMARY KEY AUTO_INCREMENT,
    shift_name VARCHAR(50),
    start_time TIME,
    end_time TIME
);

CREATE TABLE Doctor_Shifts (
    doctor_id INT,
    shift_id INT,
    PRIMARY KEY (doctor_id, shift_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (shift_id) REFERENCES Shifts(shift_id)
);

-- Insert s patients
INSERT INTO Patients (first_name, last_name, gender, birth_date, phone, email) VALUES
('Amara', 'Oketch', 'Female', '1990-08-14', '0712345678', 'amara.oketch@mail.com'),
('Kwame', 'Nyambura', 'Male', '1982-03-22', '0711122233', 'kwame.nyambura@mail.com'),
('Nuru', 'Wambui', 'Female', '1995-05-30', '0722334455', 'nuru.wambui@mail.com'),
('Malik', 'Barasa', 'Male', '1975-12-18', '0733445566', 'malik.barasa@mail.com');

-- Insert  doctors
INSERT INTO Doctors (first_name, last_name, specialization, phone, email) VALUES
('Zawadi', 'Mbogo', 'Dermatologist', '0744556677', 'zawadi.mbogo@clinic.com'),
('Amani', 'Mutua', 'Orthopedic Surgeon', '0755667788', 'amani.mutua@clinic.com'),
('Sefu', 'Njoki', 'General Physician', '0766778899', 'sefu.njoki@clinic.com');

-- Insert  appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, reason, status) VALUES
(1, 3, '2024-05-13 10:00:00', 'Skin rash consultation', 'Scheduled'),
(2, 2, '2024-05-14 12:30:00', 'Knee pain assessment', 'Completed'),
(3, 1, '2024-05-15 09:30:00', 'Routine skin check', 'Scheduled'),
(4, 2, '2024-05-16 14:00:00', 'Back pain evaluation', 'Cancelled');

-- Insert  treatments
INSERT INTO Treatments (appointment_id, description, cost) VALUES
(1, 'Allergy test and topical cream prescription', 4200.00),
(2, 'X-Ray and orthopedic consultation', 9700.00),
(3, 'Full body skin screening', 3800.00),
(4, 'Physiotherapy and pain management', 5000.00);

-- Insert  payments
INSERT INTO Payments (patient_id, amount, payment_date, method) VALUES
(1, 4200.00, '2024-05-13 10:45:00', 'M-Pesa'),
(2, 9700.00, '2024-05-14 13:00:00', 'Card'),
(3, 3800.00, '2024-05-15 10:15:00', 'Insurance');

-- Insert  shifts
INSERT INTO Shifts (shift_name, start_time, end_time) VALUES
('Morning Shift', '08:00:00', '13:00:00'),
('Afternoon Shift', '13:00:00', '18:00:00'),
('Evening Shift', '18:00:00', '23:59:00');

-- Assign doctors to shifts
INSERT INTO Doctor_Shifts (doctor_id, shift_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(3, 3);

