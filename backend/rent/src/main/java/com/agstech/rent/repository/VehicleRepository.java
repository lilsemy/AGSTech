package com.agstech.rent.repository;

import com.agstech.rent.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

// talk to DB

public interface VehicleRepository extends JpaRepository<Vehicle, String> {
    List<Vehicle> findAll();
    Optional<Vehicle> findById(String vin);

    /**
     * Function to find all Cars with specified equipments. As Spring Boot would return all Cars, that have one of the
     * specified Equipments, we also have to check, if the number of specified equipments is right.
     * @param equipmentIds
     * @param count
     * @return Vehicles v
     */

    @Query("SELECT v FROM Vehicle v JOIN v.equipments e " +
            "WHERE e.equipmentId IN :equipmentIds " +
            "GROUP BY v " +
            "HAVING COUNT(DISTINCT e.equipmentId) = :count")
    List<Vehicle> findByAllEquipmentIds(@Param("equipmentIds") List<Long> equipmentIds,
                                        @Param("count") long count);

}
