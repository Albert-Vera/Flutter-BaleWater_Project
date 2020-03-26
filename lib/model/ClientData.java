package model;

public class ClientData {
    private String nom, cognoms, adreca, localitat, provincia, email, tel;
    private int id;
    private Date dataRegistro;

    public ClientData(String nom, String cognoms, String adreca, String localitat, String provincia, String email, String tel, int id, Date dataRegistro) {
        this.nom = nom;
        this.cognoms = cognoms;
        this.adreca = adreca;
        this.localitat = localitat;
        this.provincia = provincia;
        this.email = email;
        this.tel = tel;
        this.id = id;
        this.dataRegistro = dataRegistro;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getCognoms() {
        return cognoms;
    }

    public void setCognoms(String cognoms) {
        this.cognoms = cognoms;
    }

    public String getAdreca() {
        return adreca;
    }

    public void setAdreca(String adreca) {
        this.adreca = adreca;
    }

    public String getLocalitat() {
        return localitat;
    }

    public void setLocalitat(String localitat) {
        this.localitat = localitat;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDataRegistro() {
        return dataRegistro;
    }

    public void setDataRegistro(Date dataRegistro) {
        this.dataRegistro = dataRegistro;
    }
}
