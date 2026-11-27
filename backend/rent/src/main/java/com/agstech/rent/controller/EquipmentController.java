package com.agstech.rent.controller;

import com.agstech.rent.model.Equipment;
import com.agstech.rent.repository.EquipmentRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * Controller Class for Interaction with Frontend for Filtering and fetching Vehicle Equipments
 * {@link EquipmentRepository}
 */

@RestController
@RequestMapping("/api/equipments")
@CrossOrigin(origins = "*")
public class EquipmentController {

    private final EquipmentRepository equipmentRepository;

    public EquipmentController(EquipmentRepository equipmentRepository) {
        this.equipmentRepository = equipmentRepository;
    }

    @GetMapping
    public ResponseEntity<List<Equipment>> getAllEquipments() {
        return ResponseEntity.ok(equipmentRepository.findAll());
    }
}
