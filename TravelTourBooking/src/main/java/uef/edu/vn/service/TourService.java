package uef.edu.vn.service;

import java.util.List;
import org.springframework.stereotype.Service;
import uef.edu.vn.dao.TourDAO;
import uef.edu.vn.model.Tour;

@Service
public class TourService {

    private final TourDAO tourDAO = new TourDAO();

    public List<Tour> getAllTours() {
        return tourDAO.findAll();
    }

    public Tour getTourById(int id) {
        return tourDAO.findById(id);
    }

    public List<Tour> getToursByDestinationId(int destinationId) {
        return tourDAO.findByDestinationId(destinationId);
    }

    public int saveTour(Tour tour) {
        return tourDAO.save(tour);
    }

    public int updateTour(Tour tour) {
        return tourDAO.update(tour);
    }

    public int deleteTour(int id) {
        return tourDAO.delete(id);
    }
}
