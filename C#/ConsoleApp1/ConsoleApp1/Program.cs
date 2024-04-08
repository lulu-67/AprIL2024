// // See https://aka.ms/new-console-template for more information
//
// // Console.WriteLine("Hello, World!");
// //
//
// using System.Text;
// using ConsoleApp1;
//
// // int a = 10;
// // Console.WriteLine(a);
//
// // //string concatenation
// // Console.WriteLine("The value of a is " + a);
// //
// // //string interpolation
// // double b = 3.432;
// // Console.WriteLine(b);
// // Console.WriteLine($"The value of b is {b}");
// //
// // float c = 4.3432f;
// // Console.WriteLine(c);
// //
// // decimal d = 3.5453m;
// // Console.WriteLine(d);
// //
// string s = "Welcome to C# class";
// Console.WriteLine(s);
//
// StringBuilder sb = new StringBuilder("hello world");
// Console.WriteLine($"before change: {sb}");
// sb[0] = 'H';
// Console.WriteLine($"after change:{sb}");
//
// //
// // bool flag = true;
// // Console.WriteLine(flag);
//
// // String str = null;
// // Console.WriteLine(str);
// //
// // int? i = null;
// // Console.WriteLine(i);
// //
// // if (i.HasValue)
// // {
// //     Console.WriteLine(i.Value);
// // }
// // else
// // {
// //     Console.WriteLine("i variable does not have any value");
// // }
//
// int Sunday = 1;
// int Monday = 2;
// int Tuesday = 3;
// int Wednesday = 4;
// int Thursday = 5;
// int Friday = 6;
// int Saturday = 7;
//
// int dayOfWeek = 17;
//
// if (dayOfWeek == Monday)
// {
//     Console.WriteLine("It's Monday");
// }
//
// DaysOfWeek today = DaysOfWeek.Monday;
// Console.WriteLine(today);
//

using ConsoleApp1;

ParamsPassing demo = new ParamsPassing();
int x = 30;
int y = 10;
string str = "World";
Console.WriteLine($"Before calling passing by value method: x={x}, y={y}, str={str}");
demo.PassingByValue(x, y, str);
Console.WriteLine($"After calling passing by value method: x={x}, y={y}, str={str}");
Console.WriteLine("__________________________________");
Console.WriteLine($"Before calling passing by reference method: x={x}, y={y}, str={str}");
demo.PassingByReference(ref x, ref y, ref str);
Console.WriteLine($"After calling passing by reference method: x={x}, y={y}, str={str}");

demo.AreaOfCircle(10);
demo.AreaOfCircle(10, 3);


string str1 = "hello";

Console.WriteLine(demo.IsAuthentic("Anjila", "Antra123", out str1));
Console.WriteLine(str1);

Console.WriteLine(demo.AddNumbers(20,30));
Console.WriteLine(demo.AddNumbers(20,30,40));
Console.WriteLine(demo.AddNumbers(20,30,40,50,60));

// demo.AddTwoNumbers(1,2);

