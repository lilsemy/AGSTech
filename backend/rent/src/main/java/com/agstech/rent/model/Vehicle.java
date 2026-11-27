package com.agstech.rent.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.math.BigDecimal;
import java.util.Set;

@Entity
@Table(name = "vehicle") // Exakter Tabellenname in Supabase
public class Vehicle {

    @Id
    @Column(name = "vin")
    private String vin;

    @Column(name = "licenseplate", nullable = false, unique = true)
    private String licensePlate;

    @Column(name = "mileage", nullable = false)
    private int mileage;

    @Column(name = "brand", nullable = false)
    private String brand;

    @Column(name = "model", nullable = false)
    private String model;

    @Column(name = "vehicleclass", nullable = false)
    private String vehicleClass;

    @Column(name = "fueltype", nullable = false)
    private String fuelType;

    @Column(name = "seats", nullable = false)
    private int seats;

    @Column(name = "trunkcapacity")
    private int trunkCapacity;

    @Column(name = "imageurl")
    private String imageUrl;

    @Column(name = "status")
    private String status;

    @Column(name = "dailyprice", nullable = false)
    private BigDecimal dailyPrice;

    @Column(name = "color")
    private String color;

    @Column(name = "power")
    private int power;

    @Column(name = "transmission", nullable = false)
    private String transmission;

    @Column(name = "drivetype", nullable = false)
    private String driveType;

    @Column(name = "inspectionexpirydate", nullable = false)
    private LocalDate inspectionExpiryDate;

    @Column(name = "locationid")
    private Long locationId;

    /**
     * Attribut "equipments" is fetched via connecting Table "VehicleEquipment", to store a set of equipmentIds
     */
    @ManyToMany
    @JoinTable(
            name = "vehicleequipment",
            joinColumns = @JoinColumn(name = "vin"),
            inverseJoinColumns = @JoinColumn(name = "equipmentid")
    )
    private Set<Equipment> equipments;

    public Set<Equipment> getEquipments() {
        return equipments;
    }

    public void setEquipments(Set<Equipment> equipments) {
        this.equipments = equipments;
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public int getMileage() {
        return mileage;
    }

    public void setMileage(int mileage) {
        this.mileage = mileage;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getVehicleClass() {
        return vehicleClass;
    }

    public void setVehicleClass(String vehicleClass) {
        this.vehicleClass = vehicleClass;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public int getSeats() {
        return seats;
    }

    public void setSeats(int seats) {
        this.seats = seats;
    }

    public int getTrunkCapacity() {
        return trunkCapacity;
    }

    public void setTrunkCapacity(int trunkCapacity) {
        this.trunkCapacity = trunkCapacity;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getDailyPrice() {
        return dailyPrice;
    }

    public void setDailyPrice(BigDecimal dailyPrice) {
        this.dailyPrice = dailyPrice;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getPower() {
        return power;
    }

    public void setPower(int power) {
        this.power = power;
    }

    public String getTransmission() {
        return transmission;
    }

    public void setTransmission(String transmission) {
        this.transmission = transmission;
    }

    public String getDriveType() {
        return driveType;
    }

    public void setDriveType(String driveType) {
        this.driveType = driveType;
    }

    public LocalDate getInspectionExpiryDate() {
        return inspectionExpiryDate;
    }

    public void setInspectionExpiryDate(LocalDate inspectionExpiryDate) {
        this.inspectionExpiryDate = inspectionExpiryDate;
    }

    public Long getLocationId() {
        return locationId;
    }

    public void setLocationId(Long locationId) {
        this.locationId = locationId;
    }
}