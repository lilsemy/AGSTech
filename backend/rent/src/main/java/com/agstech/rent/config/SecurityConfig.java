package com.agstech.rent.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                // CSRF deaktivieren, da wir eine stateless REST-API für Flutter bauen
                .csrf(csrf -> csrf.disable())
                // Berechtigungen für Endpunkte festlegen
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/api/auth/**").permitAll() // Register & Login öffentlich erlauben
                        .requestMatchers("/api/vehicles/**").permitAll() // Hack, später ändern
                        .requestMatchers("/api/equipments/**").permitAll() // Wir hacken einfach nochmal hihi
                        .anyRequest().authenticated()               // Alles andere erfordert Authentifizierung
                );

        return http.build();
    }
}
