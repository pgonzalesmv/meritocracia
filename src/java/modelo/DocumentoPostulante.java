package modelo;

public class DocumentoPostulante {
    private int id;
    private int idPostulante;
    private int convocatoriaId;
    private int criterioId;
    private String nombreArchivo;
    private String rutaArchivo;
    private String comentario;
    private String fechaSubida;

    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdPostulante() { return idPostulante; }
    public void setIdPostulante(int idPostulante) { this.idPostulante = idPostulante; }

    public int getConvocatoriaId() { return convocatoriaId; }
    public void setConvocatoriaId(int convocatoriaId) { this.convocatoriaId = convocatoriaId; }

    public int getCriterioId() { return criterioId; }
    public void setCriterioId(int criterioId) { this.criterioId = criterioId; }

    public String getNombreArchivo() { return nombreArchivo; }
    public void setNombreArchivo(String nombreArchivo) { this.nombreArchivo = nombreArchivo; }

    public String getRutaArchivo() { return rutaArchivo; }
    public void setRutaArchivo(String rutaArchivo) { this.rutaArchivo = rutaArchivo; }

    public String getComentario() { return comentario; }
    public void setComentario(String comentario) { this.comentario = comentario; }

    public String getFechaSubida() { return fechaSubida; }
    public void setFechaSubida(String fechaSubida) { this.fechaSubida = fechaSubida; }
}
