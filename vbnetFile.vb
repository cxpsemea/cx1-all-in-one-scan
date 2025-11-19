Imports System
Imports System.Net
Imports System.Text

Module Hello_Program

    Sub Main()
        Dim password As String = "Checkmarx!123"
        Console.WriteLine("Hello, Welcome to the world of VB.NET")
        Console.WriteLine("Password: " & password)

        ' Create HttpListener
        Dim listener As New HttpListener()
        listener.Prefixes.Add("http://localhost:8080/entry/")
        listener.Start()
        Console.WriteLine("Server running at http://localhost:8080/entry?params=Hello")

        While True
            Dim context As HttpListenerContext = listener.GetContext()
            Dim request As HttpListenerRequest = context.Request
            Dim response As HttpListenerResponse = context.Response

            ' Get the "params" query parameter
            Dim paramsValue As String = request.QueryString("params")
            If String.IsNullOrEmpty(paramsValue) Then
                paramsValue = "No 'params' provided"
            End If

            Dim responseString As String = "Value of params: " & paramsValue
            Dim buffer() As Byte = Encoding.UTF8.GetBytes(responseString)
            response.ContentLength64 = buffer.Length
            response.ContentType = "application/html"

            Dim output As System.IO.Stream = response.OutputStream
            output.Write(buffer, 0, buffer.Length)
            output.Close()
        End While
    End Sub

End Module
