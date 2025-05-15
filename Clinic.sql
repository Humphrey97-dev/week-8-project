-- Clinic Booking System Database

-- Author: Humphrey Wambu
-- Date: 2025-05-15

-- Step 1: Create the database
CREATE DATABASE clinic_booking;
USE clinic_booking;

-- Step 2: Create Patient Table
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL
);

-- Step 3: Create Doctor Table
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL
);

-- Step 4: Create Clinic_Room Table
CREATE TABLE Clinic_Room (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type VARCHAR(50) NOT NULL
);

-- Step 5: Create Appointment Table
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE CASCADE,
    CONSTRAINT uc_appointment UNIQUE (doctor_id, appointment_date, appointment_time)
);

-- Step 6: Create Appointment_Room Table (Many-to-Many relation between appointments and rooms)
CREATE TABLE Appointment_Room (
    appointment_id INT NOT NULL,
    room_id INT NOT NULL,
    PRIMARY KEY (appointment_id, room_id),
    CONSTRAINT fk_appointment FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id) ON DELETE CASCADE,
    CONSTRAINT fk_room FOREIGN KEY (room_id) REFERENCES Clinic_Room(room_id) ON DELETE CASCADE
);
