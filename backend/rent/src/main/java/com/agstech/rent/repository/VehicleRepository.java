package com.agstech.rent.repository;

import com.agstech.rent.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

// talk to DB

public interface VehicleRepository extends JpaRepository<Vehicle, String> {
    List<Vehicle> findAll();
    Optional<Vehicle> findById(String vin);
}
