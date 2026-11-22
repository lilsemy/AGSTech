package com.agstech.rent.service;

import com.agstech.rent.model.Session;
import com.agstech.rent.repository.SessionRepository;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;
import java.time.OffsetDateTime;
import java.util.Base64;

@Service
public class SessionService {
    private final SessionRepository sessionRepository;
    private final SecureRandom secureRandom = new SecureRandom();

    public SessionService(SessionRepository sessionRepository){
        this.sessionRepository = sessionRepository;
    }

    public Session createSession(Long customerId) {
        byte[] randomBytes = new byte[32];
        secureRandom.nextBytes(randomBytes);
        String token = Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
        OffsetDateTime now = OffsetDateTime.now();

        Session session = new Session();
        session.setToken(token);
        session.setCustomerId(customerId);
        session.setCreatedAt(now);
        session.setExpiresAt(now.plusDays(1));

        return sessionRepository.save(session);

    }

}
