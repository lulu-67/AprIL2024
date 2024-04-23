using ConsoleApp4.DataModel;

namespace ConsoleApp4.Repository;

public class EmployeeRepository : IRepository<Employee>
{
    private List<Employee> employees = new List<Employee>
    {
        new Employee() {Id=1, FullName="Scott", City="Sterling", Department="IT",Salary=5500 } ,
        new Employee() {Id=2, FullName="Peter", City="Sterling", Department="HR",Salary=4500 },
        new Employee() {Id=3, FullName="Laura", City="Leesburg", Department="IT",Salary=6500 },
        new Employee() {Id=4, FullName="David", City="Chicago", Department="IT",Salary=5000 },
        new Employee() {Id=5, FullName="Tracy", City="Chicago", Department="HR",Salary=5000 },
        new Employee() {Id=6, FullName="Fiona", City="Sterling", Department="IT",Salary=7500 }
    };

    public List<Employee> Search(Func<Employee, bool> Condition)
    {
        List<Employee> result = new List<Employee>();
        foreach (var employee in employees)
        {
            if (Condition(employee))
            {
                result.Add(employee);
            }
        }

        return result;
    }
}