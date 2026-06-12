package uef.edu.vn.service;

import uef.edu.vn.dao.TourDAO;
import uef.edu.vn.model.Tour;

import java.util.List;

public class TourService {

    private TourDAO tourDAO = new TourDAO();

    public List<Tour> getAllTours() {

        return tourDAO.getAllTours();
    }

    public Tour getTourById(int tourId) {

        return tourDAO.getTourById(tourId);
    }
}
