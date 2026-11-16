package com.agstech.rent.repository;
import com.agstech.rent.model.Address;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface AddressRepository extends JpaRepository<Address, Long> {
    Optional<Address> findByStreetIgnoreCaseAndHouseNumberIgnoreCaseAndPostalCodeIgnoreCaseAndCityIgnoreCaseAndCountryIgnoreCase(
            String street, String houseNumber, String postalCode, String city, String country
    );
}
