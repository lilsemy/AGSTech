package com.agstech.rent.controller;

import com.agstech.rent.dto.LoginRequest;
import com.agstech.rent.dto.RegisterRequest;
import com.agstech.rent.exception.InvalidCredentialsException;
import com.agstech.rent.model.Customer;
import com.agstech.rent.model.Session;
import com.agstech.rent.service.AuthService;
import com.agstech.rent.service.SessionService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*") // Wichtig, damit Flutter (besonders Flutter Web) zugreifen darf
public class AuthController {

    private final AuthService authService;
    private final SessionService sessionService;

    public AuthController(AuthService authService, SessionService sessionService) {
        this.authService = authService;
        this.sessionService = sessionService;
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
        try {

            Session session = authService.login(request);

            return ResponseEntity.ok(Map.of("token", session.getToken()
            ));

        } catch (InvalidCredentialsException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of(
                    "error", "INVALID_CREDENTIALS"
            ));
        }
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(@RequestHeader(required = false, value = "Authorization") String authorizationHeader) {
        SessionService.extractTokenFromHeader(authorizationHeader).ifPresent(
                token -> sessionService.deleteSession(token)
        );

        return ResponseEntity.ok(Map.of("message", "Erfolgreich abgemeldet"));
    }
}
