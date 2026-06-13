package uef.edu.vn.service;

import java.util.List;
import org.springframework.stereotype.Service;
import uef.edu.vn.dao.DestinationDAO;
import uef.edu.vn.model.Destination;

@Service
public class DestinationService {

    private final DestinationDAO destinationDAO = new DestinationDAO();

    public List<Destination> getAllDestinations() {
        return destinationDAO.findAll();
    }

    public Destination getDestinationById(int id) {
        return destinationDAO.findById(id);
    }

    public int saveDestination(Destination destination) {
        return destinationDAO.save(destination);
    }

    public int updateDestination(Destination destination) {
        return destinationDAO.update(destination);
    }

    public int deleteDestination(int id) {
        return destinationDAO.delete(id);
    }
}
