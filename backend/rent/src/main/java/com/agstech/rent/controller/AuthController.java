package com.agstech.rent.controller;

import com.agstech.rent.dto.LoginRequest;
import com.agstech.rent.dto.RegisterRequest;
import com.agstech.rent.model.Customer;
import com.agstech.rent.model.Session;
import com.agstech.rent.service.AuthService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*") // Wichtig, damit Flutter (besonders Flutter Web) zugreifen darf
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequest request) {
        try {
            Customer savedCustomer = authService.registerCustomer(request);

            return ResponseEntity.status(HttpStatus.CREATED).body(Map.of(
                    "message", "Registrierung erfolgreich",
                    "customerId", savedCustomer.getCustomerId()
            ));
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of(
                    "error", e.getMessage()
            ));
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        Session session = authService.login(request);
        //TODO exception instead of null, fine for now
        if (session != null) {
            return ResponseEntity.ok(Map.of("token", session.getToken()));
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of(
                "error", "INVALID_CREDENTIALS"
        ));
    }
}
