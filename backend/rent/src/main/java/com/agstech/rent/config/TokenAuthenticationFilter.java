package com.agstech.rent.config;

import com.agstech.rent.model.Customer;
import com.agstech.rent.repository.CustomerRepository;
import com.agstech.rent.service.SessionService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;


public class TokenAuthenticationFilter extends OncePerRequestFilter {
    private final SessionService sessionService;
    private final CustomerRepository customerRepository;

    public TokenAuthenticationFilter(SessionService sessionService, CustomerRepository customerRepository) {
        this.sessionService = sessionService;
        this.customerRepository = customerRepository;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        SessionService.extractTokenFromHeader(request.getHeader("Authorization")) //Optional token von header, wenn da, weiter
        .flatMap(token -> sessionService.getCustomerIdByToken(token))//Optional customerId von token, wenn da, weiter
        .flatMap(customerId -> customerRepository.findById(customerId))//Optional customer von customerId, wenn da, weiter
        .ifPresent(customer -> {
                    var authentication = new UsernamePasswordAuthenticationToken(customer, null, List.of());
                    SecurityContextHolder.getContext().setAuthentication(authentication);
        });
//        SessionService.extractTokenFromHeader(request.getHeader("Authorization")).ifPresent(token -> {
//
//            Long customerId = sessionService.getCustomerIdByToken(token).orElse(null);
//
//            if (customerId != null) {
//                Customer customer = customerRepository.findById(customerId).orElse(null);
//
//                if (customer != null) {
//                    var authentication = new UsernamePasswordAuthenticationToken(customer, null, List.of());
//                    SecurityContextHolder.getContext().setAuthentication(authentication);
//                }
//
//            }
//        });
//        Alternative, länger, aber leichter zu lesen

        filterChain.doFilter(request, response);
    }
}
