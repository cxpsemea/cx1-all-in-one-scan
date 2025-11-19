using System;
using System.Net;
using System.Threading;

namespace CxCE_Demo
{
    class Program
    {
        static void Main(string[] args)
        {
            HttpListener listener = new HttpListener();

            // Listen on http://localhost:8080/
            listener.Prefixes.Add("http://localhost:8080/");
            listener.Start();

            Console.WriteLine("Server started. Listening on http://localhost:8080/enter?param=...");

            // Main loop
            while (true)
            {
                HttpListenerContext ctx = listener.GetContext();
                ThreadPool.QueueUserWorkItem(o => HandleRequest(ctx));
            }
        }

        static void HandleRequest(HttpListenerContext ctx)
        {
            var request = ctx.Request;
            var response = ctx.Response;

            string password = request.QueryString["pass"] ?? "no password";

            if (request.Url.AbsolutePath == "/enter" && password == Constants.DB_PASSWORD)
            {
                // Read ?param=...
                string paramValue = request.QueryString["param"] ?? "(no param provided)";

                string responseString = $"You entered: {paramValue}";

                byte[] buffer = System.Text.Encoding.UTF8.GetBytes(responseString);
                response.ContentLength64 = buffer.Length;

                using (var output = response.OutputStream)
                {
                    output.Write(buffer, 0, buffer.Length);
                }
            }
            else
            {
                // 404
                response.StatusCode = 404;
                response.Close();
            }
        }
    }

    class Constants
    {
        public static string DB_PASSWORD = "Checkmarx123!";
    }
}
