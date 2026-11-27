package com.agstech.rent.controller;

import com.agstech.rent.dto.MeResponse;
import com.agstech.rent.model.Customer;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/me")
public class MeController {

    @GetMapping
    public MeResponse getMe(@AuthenticationPrincipal Customer customer) {
        return new MeResponse(
                customer.getCustomerId(),
                customer.getEmail(),
                customer.getFirstName(),
                customer.getLastName(),
                customer.getPhoneNumber(),
                customer.getDateOfBirth(),
                customer.getLicenseClass(),
                customer.getLicenseExpiryDate()
        );
    }
}
