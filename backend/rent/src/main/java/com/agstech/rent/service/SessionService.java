package com.agstech.rent.service;

import com.agstech.rent.model.Session;
import com.agstech.rent.repository.SessionRepository;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;
import java.time.OffsetDateTime;
import java.util.Base64;
import java.util.Optional;

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

    public Optional<Long> getCustomerIdByToken(String token) {
        Optional<Session> sessionOptional = sessionRepository.findById(token);
        if (sessionOptional.isEmpty()){
            return Optional.empty();
        }

        Session session = sessionOptional.get();

        if(session.isExpired()){
            sessionRepository.delete(session);
            return Optional.empty();
        }

        return Optional.of(session.getCustomerId());
    }

    //Hilfe methode, um den Token aus dem Header zu extrahieren. Wird auch in TokenAuthenticationFilter verwendet
    public static Optional<String> extractTokenFromHeader(String authorizationHeader) {

        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
            return Optional.of(authorizationHeader.substring(7));
        }
        return Optional.empty();
    }

    public void deleteSession(String token) {
        sessionRepository.deleteById(token);
    }

}
