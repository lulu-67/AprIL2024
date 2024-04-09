// See https://aka.ms/new-console-template for more information


using ConsoleApp2;
// c.CustomerName = "Smith";
// Console.WriteLine(c.CustomerName);

// c.Id = 3;
Customer firstCustomer = new Customer(1, "Smith", "abc@gmail.com");
Console.WriteLine($"The id for the firstCustomer is {firstCustomer.Id}");
Customer secondCustomer = new Customer(1, "Smith", "abc@gmail.com", "1234545");
Console.WriteLine($"The phone number for the second customer is {secondCustomer.Phone}");

FullTimeEmployee fte = new FullTimeEmployee(1);
fte.PerformWork();
PartTimeEmployee pte = new PartTimeEmployee(2);
pte.PerformWork();
Manager m = new Manager(12);

//Addition addition = new Addition();
// Console.WriteLine(addition.AddNumbers(1, 2, 3));

Addition.AddNumbers(1, 2, 3);

int a = 3;
Console.WriteLine(a.EvenOrOdd());

