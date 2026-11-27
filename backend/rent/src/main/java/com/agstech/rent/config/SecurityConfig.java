package com.agstech.rent.config;

import com.agstech.rent.repository.CustomerRepository;
import com.agstech.rent.service.SessionService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, SessionService sessionService, CustomerRepository customerRepository) throws Exception {
        http
                // CSRF deaktivieren, da wir eine stateless REST-API für Flutter bauen
                .csrf(csrf -> csrf.disable())
                // Session-Management auf stateless setzen
                .sessionManagement(s -> s.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                // Berechtigungen für Endpunkte festlegen
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/api/auth/**").permitAll() // Register & Login öffentlich erlauben
                        .requestMatchers("/api/vehicles/**").permitAll() // Hack, später ändern
                        .requestMatchers("/error").permitAll()
                        .anyRequest().authenticated() // Alles andere erfordert Authentifizierung
                )
                .exceptionHandling(ex -> ex.authenticationEntryPoint((request, response, authException) -> {
                    response.setStatus(401);
                    response.setContentType("application/json");
                    response.getWriter().write("{\"error\": \"NOT_LOGGED_IN\"}");
                }))
                .addFilterBefore(new TokenAuthenticationFilter(sessionService, customerRepository),
                        UsernamePasswordAuthenticationFilter.class
                );

        return http.build();
    }
}
