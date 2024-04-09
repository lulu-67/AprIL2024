namespace ConsoleApp2;

public abstract class Employee
{
    public Employee(int id)
    {
        Id = id;
    }
    
    public int Id { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
    public string Phone { get; set; }
    public string Address { get; set; }

    public abstract void PerformWork();
    
    // public virtual void PerformWork()
    // {
    //     Console.WriteLine("Employee does some job");
    // }
}

public class FullTimeEmployee : Employee
{
    public FullTimeEmployee(int id): base(id)
    {
        
    }
    public decimal BiweeklyPay { get; set; }
    public string Benefits { get; set; }
    
    public override void PerformWork()
    {
        Console.WriteLine("Full time employees work 40 hours a week");
    }
    
}

public sealed class PartTimeEmployee : Employee
{
    public PartTimeEmployee(int id): base(id)
    {
        
    }
    public decimal HourlyPay { get; set; }
    
    public override void PerformWork()
    {
        Console.WriteLine("Part time employees work 20 hours a week");
    }
    
}

public class Manager : FullTimeEmployee
{
    public Manager(int id): base(id)
    {
        
    }
    public decimal ExtraBonus { get; set; }

    public void AttendMeeting()
    {
        Console.WriteLine("Managers have to attend meetings");
    }
}

// public class Test : PartTimeEmployee
// {
//     
// }