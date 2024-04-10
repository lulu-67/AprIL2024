// // See https://aka.ms/new-console-template for more information
//
//
// using ConsoleApp2;
// // c.CustomerName = "Smith";
// // Console.WriteLine(c.CustomerName);
//
// // c.Id = 3;
// Customer firstCustomer = new Customer(1, "Smith", "abc@gmail.com");
// Console.WriteLine($"The id for the firstCustomer is {firstCustomer.Id}");
// Customer secondCustomer = new Customer(1, "Smith", "abc@gmail.com", "1234545");
// Console.WriteLine($"The phone number for the second customer is {secondCustomer.Phone}");
//
// FullTimeEmployee fte = new FullTimeEmployee(1);
// fte.PerformWork();
// PartTimeEmployee pte = new PartTimeEmployee(2);
// pte.PerformWork();
// Manager m = new Manager(12);
//
// //Addition addition = new Addition();
// // Console.WriteLine(addition.AddNumbers(1, 2, 3));
//
// Addition.AddNumbers(1, 2, 3);
//
// int a = 3;
// Console.WriteLine(a.EvenOrOdd());

using ConsoleApp2;

EmployeeRepository employeeRepository = new EmployeeRepository();
employeeRepository.CreateEmployee(new FullTimeEmployee(1));
employeeRepository.CreateEmployee(new PartTimeEmployee(2));
employeeRepository.CreateEmployee(new Manager(3));
List<Employee> employees = employeeRepository.GetAllEmployees();
foreach (var employee in employees)
{
    Console.WriteLine(employee.Id + "\t");
}
