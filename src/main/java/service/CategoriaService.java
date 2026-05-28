// service/CategoriaService.java
package service;

import dao.CategoriaDAO;
import model.Categoria;

import java.util.List;

public class CategoriaService {

    private final CategoriaDAO categoriaDAO = new CategoriaDAO();

    public List<Categoria> listar() {
        return categoriaDAO.listar();
    }

    public Categoria buscarPorId(int id) {
        return categoriaDAO.buscarPorId(id);
    }

    public boolean inserir(Categoria categoria) {
        return categoriaDAO.inserir(categoria);
    }
}