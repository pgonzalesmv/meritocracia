package modelo;

public class CriterioEvaluacion {
    private int id;
    private int convocatoriaId;
    private String categoria;
    private String subcategoria;
    private String descripcion;
    private double puntajeMaximo;
    private String formulaCalculo;
    private int orden;
    private boolean activo;

    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getConvocatoriaId() { return convocatoriaId; }
    public void setConvocatoriaId(int convocatoriaId) { this.convocatoriaId = convocatoriaId; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public String getSubcategoria() { return subcategoria; }
    public void setSubcategoria(String subcategoria) { this.subcategoria = subcategoria; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public double getPuntajeMaximo() { return puntajeMaximo; }
    public void setPuntajeMaximo(double puntajeMaximo) { this.puntajeMaximo = puntajeMaximo; }

    public String getFormulaCalculo() { return formulaCalculo; }
    public void setFormulaCalculo(String formulaCalculo) { this.formulaCalculo = formulaCalculo; }

    public int getOrden() { return orden; }
    public void setOrden(int orden) { this.orden = orden; }

    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
}
