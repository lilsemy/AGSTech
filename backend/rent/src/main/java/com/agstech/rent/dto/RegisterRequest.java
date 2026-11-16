package com.agstech.rent.dto;

import java.time.LocalDate;

public class RegisterRequest {
    public String firstName;
    public String lastName;
    public String email;
    public String password; // Klartext-Passwort vom Frontend
    public String phoneNumber;
    public LocalDate dateOfBirth;
    public String licenseClass;
    public LocalDate licenseExpiryDate;
    public String street;
    public String houseNumber;
    public String postalCode;
    public String city;
    public String country;
}
