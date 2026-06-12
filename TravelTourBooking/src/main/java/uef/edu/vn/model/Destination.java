/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uef.edu.vn.model;

import java.util.Objects;

/**
 *
 * @author LENOVO
 */
public class Destination {

    private int destinationId;
    private String destinationName;
    private String country;
    private String city;
    private String description;
    private String imageUrl;

    public Destination() {
    }

    public Destination(int destinationId, String destinationName, String country, String city, String description, String imageUrl) {
        this.destinationId = destinationId;
        this.destinationName = destinationName;
        this.country = country;
        this.city = city;
        this.description = description;
        this.imageUrl = imageUrl;
    }

    public int getDestinationId() {
        return destinationId;
    }

    public void setDestinationId(int destinationId) {
        this.destinationId = destinationId;
    }

    public String getDestinationName() {
        return destinationName;
    }

    public void setDestinationName(String destinationName) {
        this.destinationName = destinationName;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "Destination{" + "destinationId=" + destinationId + ", destinationName=" + destinationName + '}';
    }

    @Override
    public int hashCode() {
        return Objects.hash(destinationId);
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) {
            return true;
        }
        if (object == null || getClass() != object.getClass()) {
            return false;
        }
        Destination that = (Destination) object;
        return destinationId == that.destinationId;
    }
}
