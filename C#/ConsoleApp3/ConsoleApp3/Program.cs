// See https://aka.ms/new-console-template for more information

using ConsoleApp3;
using ConsoleApp3.Presentation;

//Console.WriteLine("Hello, World!");

// Console.WriteLine(GenericDemo.AreEqual(12, 24));
// Console.WriteLine(GenericDemo.AreEqual(12.344, 24.434));
// Console.WriteLine(GenericDemo.AreEqual("1232", "3223"));
// Console.WriteLine(GenericDemo.AreEqual("12.344", 24.434));

// Console.WriteLine(GenericDemo<int>.AreEqual(2, 2));
// Console.WriteLine(GenericDemo<double>.AreEqual(12.54, 24.545));
// Console.WriteLine(GenericDemo<string>.AreEqual("rew", "gfdgd"));
// Console.WriteLine(GenericDemo<string>.AreEqual("rew", "fsdjf"));

ManageCustomer manageCustomer = new ManageCustomer();
manageCustomer.Run();

Dictionary<int, string> dict = new Dictionary<int, string>();