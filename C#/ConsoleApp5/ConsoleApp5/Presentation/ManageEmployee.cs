using ConsoleApp5.Repositories;
using ConsoleApp5.DataModel;
namespace ConsoleApp5.Presentation;

public class ManageEmployee
{
    private EmployeeRepository _employeeRepository = new EmployeeRepository();


    // private Employee Demo(Employee employee)
    // {
    //     return employee;
    // }

        private void SelectDemo()
        {
            
             // var result = from employee in _employeeRepository.GetEmployees()
             //     select employee;
             //
             // foreach (var employee in result)
             // {
             //     Console.WriteLine(employee.Id + "\t" + employee.FullName + "\t" + employee.Age + "\t" + employee.Department + "\t" + employee.Salary);
             // }
            
        //method syntax

        // var result = _employeeRepository.GetEmployees().Select(employee => employee);
        // foreach (var employee in result)
        // {
        //     Console.WriteLine(employee.Id + "\t" + employee.FullName + "\t" + employee.Age + "\t" + employee.Department + "\t" + employee.Salary);
        // }
        
        //Query syntax
        
            // var result = from employee in _employeeRepository.GetEmployees()
            //      select employee.FullName;
            //
            // foreach (var name in result)
            // {
            //     Console.WriteLine(name);
            // }
            //
            //method Syntax

            // var result = _employeeRepository.GetEmployees().Select(employee => employee.FullName);
            // foreach (var name in result)
            // {
            //     Console.WriteLine(name);
            // }
            
            //Query Syntax
            // var result = from employee in _employeeRepository.GetEmployees()
            //     select new
            //     {
            //         Id = employee.Id,
            //         FullName = employee.FullName,
            //         Department = employee.Department
            //     };

            // foreach (var employee in result)
            // {
            //     Console.WriteLine(employee.Id + "\t" + employee.Department + "\t" + employee.FullName);
            // }
            
            //Method Syntax

            // var result = _employeeRepository.GetEmployees().Select(employee =>
            //     new {Id = employee.Id, FullName = employee.FullName, Department= employee.Department });
            //
            // foreach (var employee in result)
            // {
            //     Console.WriteLine(employee.Id + "\t" + employee.Department + "\t" + employee.FullName);
            // }
            
            //Distinct
            
            //query syntax 

            // var result = (from employee in _employeeRepository.GetEmployees()
            //     select employee.Department).Distinct();
           
            //method syntax
            // var result = _employeeRepository.GetEmployees().Select(employee => employee.Department).Distinct();
            // foreach (var department in result)
            // {
            //     Console.WriteLine(department);
            // }
            
            //single, singleOrDefault, first, firstOrDefault
            //method syntax

            var result = _employeeRepository.GetEmployees().Select(employee => new
            {
                Id = employee.Id,
                FullName = employee.FullName,
                Department = employee.Department
            }).FirstOrDefault(x => x.Department == "Marketing") ?? new {Id= -1, FullName= "N/A", Department = "N/A"};
            
            Console.WriteLine(result.Id + "\t" + result.Department+ "\t" + result.FullName);


            // var result = _employeeRepository.GetEmployees().Select(employee => new
            // {
            //     Id = employee.Id,
            //     FullName = employee.FullName,
            //     Department = employee.Department
            // }).SingleOrDefault(x => x.Department == "SDFJDSJF")?? new{Id= -1, FullName= "N/A", Department = "N/A"};
            //
            //Console.WriteLine(result.Id + "\t" + result.Department+ "\t" + result.FullName);
        }

        private void OrderByDemo()
        {
            //Query Syntax
            // var result = from employee in _employeeRepository.GetEmployees()
            //     orderby employee.Salary descending , employee.FullName descending 
            //     select new
            //     {
            //         Id = employee.Id,
            //         FullName = employee.FullName,
            //         Salary = employee.Salary
            //     };

            //Method syntax
            var result = _employeeRepository.GetEmployees().OrderByDescending(x => x.Salary).
                ThenByDescending(x => x.FullName).Select(employee=> new
            {
                Id = employee.Id,
                FullName = employee.FullName,
                Salary = employee.Salary
            });
            foreach (var employee in result)
            {
                Console.WriteLine(employee.Id + "\t" + employee.Salary+ "\t" + employee.FullName);
            }
            
            

        }

        private void WhereDemo()
        {
            //Query syntax

            // var result = from employee in _employeeRepository.GetEmployees()
            //     where employee.Salary > 7000
            //     select new
            //     {
            //         Id = employee.Id,
            //         FullName = employee.FullName,
            //         Salary = employee.Salary
            //     };
            
            //Method syntax

            var result = _employeeRepository.GetEmployees().Where(x => x.Salary > 7000).Select(employee => new
            {
                Id = employee.Id,
                FullName = employee.FullName,
                Salary = employee.Salary
            });;
                
            foreach (var employee in result)
            {
                Console.WriteLine(employee.Id + "\t" + employee.Salary + "\t" + employee.FullName);
            }
           
        }

        private void QuantifierDemo()
        {
            //Method Syntax

            // var result = _employeeRepository.GetEmployees().All(employee => employee.Salary > 4000);
            // Console.WriteLine(result);
            
            var result = _employeeRepository.GetEmployees().Any(employee => employee.Salary > 7000);
            Console.WriteLine(result);
        }

        private void GroupByDemo()
        {
            //Query syntax
            //group by employee department

            // var result = from employee in _employeeRepository.GetEmployees()
            //     group employee by employee.Department;

            //method syntax

            var result = _employeeRepository.GetEmployees().GroupBy(employee => employee.Department);

            foreach (var group in result)
            {
                Console.WriteLine($"{group.Key} Department");

                foreach (var employee in group)
                {
                    Console.WriteLine(employee.Id + "\t" + employee.Salary + "\t" + employee.FullName);
                }
            }
        }

        public void AggregationDemo()
        {
            //method syntax

            // var result = _employeeRepository.GetEmployees().Average(employee => employee.Salary);
            // Console.WriteLine(result);
            
            //get average salary by each department

            var result = _employeeRepository.GetEmployees().GroupBy(employee => employee.Department).Select(x => new
            {
                Department = x.Key,
                AverageSalary = Math.Round(x.Average(employee => employee.Salary), 2),
                TotalSalary = x.Sum(employee => employee.Salary)
            });

            foreach (var employee in result)
            {
                Console.WriteLine(employee.Department + "\t" + employee.AverageSalary + "\t" + employee.TotalSalary);
            }
        }



        public void Run()
        {
           SelectDemo();
        }
}