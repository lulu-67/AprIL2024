namespace ConsoleApp2;

public class Customer
{
    public Customer(int id, string customerName, string email)
    {
        Id = id;
        CustomerName = customerName;
        Email = email;
    }
    
    public Customer(int id, string customerName, string email, string phone)
    {
        Id = id;
        CustomerName = customerName;
        Email = email;
        Phone = phone;
    }

    
    //full version property
    // private string customerName;  //backing field
    // public string CustomerName
    // {
    //     get
    //     {
    //         return customerName;
    //     }
    //     set
    //     {
    //         customerName = value;
    //     }
    // }

    //auto-generated property

    public string CustomerName { get; set; }

    private int id;

    public int Id
    {
        get
        {
            return id;
        } 
        set
        {
            id = value;
        }
    }
    
    public string Email { get; set; }
    public string Phone { get; set; }

}