package com.agstech.rent.service;

import com.agstech.rent.dto.LoginRequest;
import com.agstech.rent.dto.RegisterRequest;
import com.agstech.rent.exception.InvalidCredentialsException;
import com.agstech.rent.model.Customer;
import com.agstech.rent.model.Address;
import com.agstech.rent.model.Session;
import com.agstech.rent.repository.CustomerRepository;
import com.agstech.rent.repository.AddressRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.OffsetDateTime;
import java.util.Optional;
import java.time.LocalDate;
import java.time.Period;

@Service
public class AuthService {

    private final CustomerRepository customerRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final AddressRepository addressRepository;
    private final SessionService sessionService;

    public AuthService(CustomerRepository customerRepository, AddressRepository addressRepository, SessionService sessionService) {
        this.customerRepository = customerRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
        this.addressRepository = addressRepository;
        this.sessionService = sessionService;
    }

    @Transactional
    public Customer registerCustomer(RegisterRequest request) {
        // 1. Prüfen, ob E-Mail bereits vergeben ist
        if (customerRepository.existsByEmail(request.email)) {
            throw new RuntimeException("E-Mail-Adresse wird bereits verwendet.");
        }
        //Prüfen ob Fahrer mindestens 18 ist
        if (Period.between(request.dateOfBirth, LocalDate.now()).getYears() < 18){
            throw new RuntimeException("Fahrer muss mindestens 18Jahre alt sein");
        }
        //Prüfen ob Führerschein abgelaufen ist oder heute abläuft --> muss mindestens bis morgen gültig sein
        if (request.licenseExpiryDate.isBefore(LocalDate.now()) || request.licenseExpiryDate.isEqual(LocalDate.now())){
            throw new RuntimeException("Der Fahrer muss einen gültigen Führerschein besitzen");
        }

        // 2. Adresse suchen oder neu anlegen (mit .trim() gegen versehentliche Leerzeichen aus Flutter)
        String street = request.street.trim();
        String houseNumber = request.houseNumber.trim();
        String postalCode = request.postalCode.trim();
        String city = request.city.trim();
        String country = request.country.trim();

        Address address = addressRepository
                .findByStreetIgnoreCaseAndHouseNumberIgnoreCaseAndPostalCodeIgnoreCaseAndCityIgnoreCaseAndCountryIgnoreCase(
                        street, houseNumber, postalCode, city, country
                )
                .orElseGet(() -> {
                    Address newAddress = new Address();
                    newAddress.setStreet(street);
                    newAddress.setHouseNumber(houseNumber);
                    newAddress.setPostalCode(postalCode);
                    newAddress.setCity(city);
                    newAddress.setCountry(country);
                    return addressRepository.save(newAddress);
                });

        // 3. Neues Customer-Objekt befüllen und die ID der gefundenen/neuen Adresse setzen
        Customer customer = new Customer();
        customer.setFirstName(request.firstName);
        customer.setLastName(request.lastName);
        customer.setEmail(request.email);
        customer.setPhoneNumber(request.phoneNumber);
        customer.setDateOfBirth(request.dateOfBirth);
        customer.setLicenseClass(request.licenseClass);
        customer.setLicenseExpiryDate(request.licenseExpiryDate);
        customer.setAddressId(address.getAddressId());

        // 4. Passwort hashen und Registrierungszeitpunkt setzen
        customer.setPasswordHash(passwordEncoder.encode(request.password));
        customer.setRegistrationDate(OffsetDateTime.now());

        // 5. In Supabase speichern
        return customerRepository.save(customer);
    }

    public Session login(LoginRequest request) throws InvalidCredentialsException {
        Optional<Customer> customer = customerRepository.findByEmail(request.email());

        if (customer.isEmpty()) {
            throw new InvalidCredentialsException("Ungültige Anmeldedaten");
        }

        if (!passwordEncoder.matches(request.password(), customer.get().getPasswordHash())) {
            throw new InvalidCredentialsException("Ungültige Anmeldedaten");
        }

        return sessionService.createSession(customer.get().getCustomerId());
    }
}
