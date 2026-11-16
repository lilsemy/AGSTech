package com.agstech.rent.service;

import com.agstech.rent.dto.RegisterRequest;
import com.agstech.rent.model.Customer;
import com.agstech.rent.model.Address;
import com.agstech.rent.repository.CustomerRepository;
import com.agstech.rent.repository.AddressRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.OffsetDateTime;

@Service
public class AuthService {

    private final CustomerRepository customerRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final AddressRepository addressRepository;

    public AuthService(CustomerRepository customerRepository, AddressRepository addressRepository) {
        this.customerRepository = customerRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
        this.addressRepository = addressRepository;
    }

    @Transactional
    public Customer registerCustomer(RegisterRequest request) {
        // 1. Prüfen, ob E-Mail bereits vergeben ist
        if (customerRepository.existsByEmail(request.email)) {
            throw new RuntimeException("E-Mail-Adresse wird bereits verwendet.");
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
}
