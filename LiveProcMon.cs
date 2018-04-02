using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace LiveProcMon
{
    class Program
    {
        static void Main(string[] args)
        {
            Thread t = new Thread(myThread);
            t.Start();

            Console.WriteLine("Press any key to exit");
            Console.ReadKey();
        }

        private static List<string> lstProcesses = new List<string>();
        private static bool firstRunDone = false;
        private static void myThread()
        {
            while (true)
            {
                if (firstRunDone == false)
                {
                    Process[] processes = Process.GetProcesses();
                    foreach (Process p in processes)
                    {
                        lstProcesses.Add(p.ProcessName);
                        //Console.WriteLine(p.ProcessName);
                    }
                    firstRunDone = true;
                }
                else
                {
                    Process[] processes = Process.GetProcesses();
                    foreach (Process p in processes)
                    {
                        if (!lstProcesses.Contains(p.ProcessName))
                        {
                            lstProcesses.Add(p.ProcessName);
                            Console.WriteLine(DateTime.Now.ToString() + " : New process detected = " + p.ProcessName);
                        }
                    }
                }
            }

        }
    }
}
