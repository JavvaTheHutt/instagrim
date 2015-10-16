package uk.ac.dundee.computing.aec.instagrim.stores;

/**
 *
 * @author MatthewLang
 */
//Session bean in order to Store Profile Info.
public class ProfileBean {
    private String firstName= null;
    private String lastName= null;
    private String email= null;
    private String street= null;
    private String city= null;
    private int postCode= 0;
    private Pic avatar= null;
    
    public void ProfileBean(){
        
    }
    
    public void setFirstName(String firstName)
    {
        this.firstName= firstName;
    }
    
    public void setLastName(String lastName)
    {
        this.lastName= lastName;
    }
    
    public void setEmail(String email)
    {
        this.email= email;
    }
    
    public void setAddress(String street, String city, int postCode)
    {
        this.street= street;
        this.city= city;
        this.postCode= postCode;
    }
    
    public void setAvatar(Pic avatar)
    {
        this.avatar=avatar;
    }
    
    public String getFirstName()
    {
        return firstName;
    }
    
    public String getLastName()
    {
        return lastName;
    }
    
    public String getEmail()
    {
        return email;
    }
    
    public String getAddress()
    {
        String address = "Street: " + getStreet() + "<br>City: " + getCity() + "<br>PostCode: " + getPostCode();
        return address;
    }
    
    public String getStreet()
    {
        return street;
    }
    
    public String getCity()
    {
        return city;
    }
    
    public int getPostCode()
    {
        return postCode;
    }
    
    public Pic getAvatar()
    {
        return avatar;
    }
        
}
