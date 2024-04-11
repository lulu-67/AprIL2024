namespace ConsoleApp4;

public class FileProcessor
{
    public void ProcessFile(String FileName)
    {
        FileStream fileStream = null;
        try
        {
            //open the file stream
            fileStream = new FileStream("Filename.txt", FileMode.Open);
            //
            //perform some operation
            //
            fileStream.Close();
        }
        catch (IOException ex)
        {
            //handle exception
        }
        finally
        {
            if (fileStream != null)
            {
                fileStream.Dispose();
            }
        }
    }
}