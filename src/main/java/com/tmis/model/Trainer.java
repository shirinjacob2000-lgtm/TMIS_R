package com.tmis.model;

public class Trainer {

    private int trainerId;
    private String trainerName;
    private String trainerDesignation;
    private String employeeId;
    private String type;
    private String office;
    private int valid; // 0 = ACTIVE, 1 = DISABLED

    public int getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(int trainerId) {
        this.trainerId = trainerId;
    }

    public String getTrainerName() {
        return trainerName;
    }

    public void setTrainerName(String trainerName) {
        this.trainerName = trainerName;
    }

    public String getTrainerDesignation() {
        return trainerDesignation;
    }

    public void setTrainerDesignation(String trainerDesignation) {
        this.trainerDesignation = trainerDesignation;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String l) {
        this.employeeId = l;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getOffice() {
        return office;
    }

    public void setOffice(String office) {
        this.office = office;
    }

    public int getValid() {
        return valid;
    }

    public void setValid(int valid) {
        this.valid = valid;
    }
}

