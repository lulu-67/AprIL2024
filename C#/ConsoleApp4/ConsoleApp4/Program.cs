/*// See https://aka.ms/new-console-template for more information

//Console.WriteLine("Hello, World!");

using ConsoleApp4;
using ConsoleApp4.Presentation;

//MathDelegate mathDelegate = new MathDelegate(ArithmeticOperation.Add);
// MathDelegate mathDelegate = new MathDelegate(ArithmeticOperation.Subtract);
// Console.WriteLine(mathDelegate(40, 10));

// PreDefinedDelegates preDefinedDelegates = new PreDefinedDelegates();
// preDefinedDelegates.ActionExample();
// preDefinedDelegates.PredicateDemo();
// preDefinedDelegates.FuncExample();
//
// var person = new
// {
//     Name = "Smith",
//     Age = 30
// };

ManageEmployee manageEmployee = new ManageEmployee();
manageEmployee.Print();*/
using ConsoleApp4;

try
{
    Console.WriteLine("Enter first number:");
    int num1 = Convert.ToInt32(Console.ReadLine());

    if (num1 < 0)
    {
        throw new NumberException();
    }

    Console.WriteLine("Enter second number:");
    int num2 = Convert.ToInt32(Console.ReadLine());
    if (num2 < 0)
    {
        throw new NumberException();
    }

    Console.WriteLine("Enter the operator");
    string operation = Console.ReadLine();

    ExceptionHandlingDemo demo = new ExceptionHandlingDemo();
    Console.WriteLine(demo.Calculate(num1, num2, operation));
}
catch (DivideByZeroException ex)
{
    Console.WriteLine(ex.Message);
}
catch (ArgumentOutOfRangeException ex)
{
    Console.WriteLine(ex.Message);
}
catch (FormatException ex)
{
    Console.WriteLine(ex.Message);
}
catch (NumberException ex)
{
    Console.WriteLine(ex.Message);
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
}
finally
{
    Console.WriteLine("Hello Finally Block");
}
