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
            stopMonitoring = true;
        }

        private static List<string> lstProcesses = new List<string>();
        private static bool firstRunDone = false;
        private static Process[] processes = null;
        private static bool stopMonitoring = false;
        private static void myThread()
        {
            while (stopMonitoring == false)
            {
                if (firstRunDone == false)
                {
                    processes = Process.GetProcesses();
                    foreach (Process p in processes)
                    {
                        string processData = p.ProcessName + "#" + p.Id;
                        lstProcesses.Add(processData);
                        Console.WriteLine(DateTime.Now.ToString() + " : Initial process = " + processData);
                    }
                    firstRunDone = true;
                }
                else
                {
                    processes = Process.GetProcesses();
                    // pour chaque process sauvegardé, rechercher s'il existe toujours en mémoire
                    foreach(string processData in lstProcesses)
                    {
                        string[] tab = processData.Split('#');
                        string name = tab[0];
                        int id = int.Parse(tab[1]);
                        bool found = false;
                        foreach(Process p in processes)
                        {
                            if (p.ProcessName.Equals(name) && (p.Id == id))
                            {
                                found = true;
                                break;
                            }
                        }
                        if (found == false)
                        {
                            Console.WriteLine(DateTime.Now.ToString() + " : Process not in memory anymore = " + processData);
                            lstProcesses.Remove(processData);
                            break;
                        }
                    }

                    // pour chaque process en mémoire, rechercher s'il existe dans la liste des process sauvegardés
                    foreach (Process p in processes)
                    {
                        string processData = p.ProcessName + "#" + p.Id;
                        if (!lstProcesses.Contains(processData))
                        {
                            lstProcesses.Add(processData);
                            Console.WriteLine(DateTime.Now.ToString() + " : New process detected = " + processData);
                        }
                    }
                }
                Thread.Sleep(250);
            }
        }
    }

}
