package uef.edu.vn.service;

import java.util.List;
import org.springframework.stereotype.Service;
import uef.edu.vn.dao.ItineraryDAO;
import uef.edu.vn.model.Itinerary;

@Service
public class ItineraryService {

    private final ItineraryDAO itineraryDAO = new ItineraryDAO();

    public List<Itinerary> getAllItineraries() {
        return itineraryDAO.findAll();
    }

    public Itinerary getItineraryById(int id) {
        return itineraryDAO.findById(id);
    }

    public List<Itinerary> getItinerariesByTourId(int tourId) {
        return itineraryDAO.findByTourId(tourId);
    }

    public int saveItinerary(Itinerary itinerary) {
        return itineraryDAO.save(itinerary);
    }

    public int updateItinerary(Itinerary itinerary) {
        return itineraryDAO.update(itinerary);
    }

    public int deleteItinerary(int id) {
        return itineraryDAO.delete(id);
    }
}
