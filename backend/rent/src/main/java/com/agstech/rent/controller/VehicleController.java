package com.agstech.rent.controller;

import com.agstech.rent.model.Vehicle;
import com.agstech.rent.service.VehicleService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.List;
import java.util.Optional;

// take requests from flutter and returns responses

@RestController
@RequestMapping("/api/vehicles")
@CrossOrigin(origins = "*") // Wichtig, damit Flutter (besonders Flutter Web) zugreifen darf
public class VehicleController {

    private final VehicleService vehicleService;

    public VehicleController(VehicleService vehicleService) {
        this.vehicleService = vehicleService;
    }

    @GetMapping
    public ResponseEntity<List<Vehicle>> getAllVehicles(
            @RequestParam(required = false) List<Long> equipments) {
        List<Vehicle> vehicles = vehicleService.getVehiclesByEquipments(equipments);
        return ResponseEntity.ok(vehicles);
    }

    @GetMapping("/{vin}")
    public ResponseEntity<Vehicle> getVehicleByVin(@PathVariable String vin) {
        Optional<Vehicle> vehicle = vehicleService.getVehicleByVin(vin);

        if (vehicle.isPresent()) {
            return ResponseEntity.ok(vehicle.get());
        } else {
            return ResponseEntity.notFound().build();
        }

    }
}
