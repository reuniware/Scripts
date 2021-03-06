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
        private static string processData = "";
        private static string[] tab = null;
        private static string name = "";
        private static int id = -1;
        private static bool found = false;
        private static bool killNewProcess = false; // Force killing of any new process (apart "cmd") ; a shortcut to cmd 
                                                    // should be created on the desktop prior to launching this app

        private static void myThread()
        {
            while (stopMonitoring == false)
            {
                if (firstRunDone == false)
                {
                    processes = Process.GetProcesses();
                    foreach (Process p in processes)
                    {
                        processData = p.ProcessName + "#" + p.Id;
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
                        tab = processData.Split('#');
                        name = tab[0];
                        id = int.Parse(tab[1]);
                        found = false;
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
                        processData = p.ProcessName + "#" + p.Id;
                        if (!lstProcesses.Contains(processData))
                        {
                            lstProcesses.Add(processData);
                            Console.WriteLine(DateTime.Now.ToString() + " : New process detected = " + processData);
                            if (killNewProcess == true)
                            {
                                if (!p.ProcessName.ToLower().Trim().Equals("cmd") && !p.ProcessName.ToLower().Trim().Equals("conhost"))
                                {
                                    try
                                    {
                                        p.Kill();
                                    }
                                    catch (Exception)
                                    {

                                    }
                                }
                            }
                        }
                    }
                }
                Thread.Sleep(250);
            }
        }
    }

}
