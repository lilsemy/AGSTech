package com.agstech.rent.repository;

import com.agstech.rent.model.Equipment;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Connection Class to Vehicle Equipments
 */

public interface EquipmentRepository extends JpaRepository<Equipment, Long> {
}
