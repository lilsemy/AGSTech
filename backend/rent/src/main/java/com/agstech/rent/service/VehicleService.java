package com.agstech.rent.service;

import com.agstech.rent.model.Vehicle;
import com.agstech.rent.repository.VehicleRepository;
import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//import java.time.OffsetDateTime;

import java.util.List;
import java.util.Optional;

// application logic

@Service
public class VehicleService {
    private final VehicleRepository vehicleRepository;

    public VehicleService(VehicleRepository vehicleRepository) {
        this.vehicleRepository = vehicleRepository;
    }

    public List<Vehicle> getAllVehicles() {
        return vehicleRepository.findAll();
    }

    public Optional<Vehicle> getVehicleByVin(String vin) {
        return vehicleRepository.findById(vin);
    }
}