using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace HttpBanner
{
    class Program
    {
        static void Main(string[] args)
        {
            for (int i = 0; i < 255; i++)
            {
                string ip = "192.168.1." + i;
                try
                {
                    HttpWebRequest req = (HttpWebRequest)WebRequest.Create("http://" + ip);
                    req.Timeout = 250;
                    req.Method = "HEAD";
                    HttpWebResponse resp = (HttpWebResponse)req.GetResponse();

                    Console.WriteLine(ip + " : Server = " + resp.Headers["Server"]);

                    /*string str = "";
                    Stream s = resp.GetResponseStream();
                    int b = 0;
                    while (b != -1)
                    {
                        b = s.ReadByte();
                        str = str + (char)b;
                    }
                    str = str.Replace("\r", "");
                    str = str.Replace("\n", "");
                    Console.WriteLine("ok : " + ip + " : " + str);*/

                    /*foreach(string header in resp.Headers)
                    {
                        Console.WriteLine(header + " " + resp.Headers[header]);
                    }*/
                }
                catch (Exception)
                {
                    //Console.WriteLine("ko : " + ip);
                }
            }
            Console.ReadLine();
        }
    }
}
