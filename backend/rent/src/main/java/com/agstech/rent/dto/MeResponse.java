package com.agstech.rent.dto;

import java.time.LocalDate;

public record MeResponse(Long customerId,
                         String email,
                         String firstName,
                         String lastName,
                         String phoneNumber,
                         LocalDate dateOfBirth,
                         String licenseClass,
                         LocalDate licenseExpiryDate) {
}
