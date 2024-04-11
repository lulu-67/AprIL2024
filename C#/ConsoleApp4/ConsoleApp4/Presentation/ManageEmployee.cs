using ConsoleApp4.DataModel;
using ConsoleApp4.Repository;

namespace ConsoleApp4.Presentation;

public class ManageEmployee
{
    private EmployeeRepository _employeeRepository = new EmployeeRepository();

    public void Print()
    {
        List<Employee> employees = _employeeRepository.Search(employee => employee.Department == "IT");
        foreach (var employee in employees)
        {
            Console.WriteLine(employee.Id + "\t" + employee.City + "\t" + employee.FullName + "\t" + employee.Department);
        }
        
    }
}