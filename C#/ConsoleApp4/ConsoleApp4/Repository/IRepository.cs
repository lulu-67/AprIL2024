namespace ConsoleApp4.Repository;

public interface IRepository <T> where T: class
{
    List<T> Search(Func<T, bool>Condition);
}