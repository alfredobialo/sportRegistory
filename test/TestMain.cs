using System;
using asom.apps.inOut.core;
using asom.apps.inOut.core.model.authentication;
using itrex.businessObjects.model.core;
using itrex.businessObjects.model.core.util;
using static System.Console;
namespace test
{
    class TestMain
    {
        static void Main()
        {
            AppConfig.ConnectionString = "data source =.; initial catalog = sports_db; persist security info = True; user id = sa; password = asomservice; MultipleActiveResultSets = True; App = EntityFramework";

            var acc = SuperAdminIdentity.CreateNewAdmin("somkene", "somkene", "Maryann Somkene");
            if(acc.IsSuccess)
            {
                Console.WriteLine("Account Created Successfully!");

            }
            else
            {
                Console.WriteLine(acc.Message);
                
            }
            
            //87985546
            var result =BinaryConvertion.ConvertFromBaseN_To_N1("53e8d8a",16, 10);
            
                        Console.WriteLine($"Application Unit Test Started! : conversion ===> {result}");
                        string hexMap = "0123456789abcdef".ToUpper();
                        string num = "";
                        string values = "";
                        for (int i = 0; i < num.Length; i++)
                        {
                            values += hexMap.IndexOf(num.Substring(i, 1));
                        }
                 
        Console.Write(values);
            Console.ReadLine();
        }
    }
}
