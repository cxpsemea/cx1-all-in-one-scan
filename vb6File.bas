Module Hello
  Sub Main()
      Dim password  
      password = "Checkmarx!123"
      MsgBox("Hello, World! " & password) 
  End Sub

  Function FileToString(strFilename As String) As String
    iFile = FreeFile
    Open strFilename For Input As #iFile
    FileToString = StrConv(InputB(LOF(iFile), iFile), vbUnicode)
    Close #iFile
  End Function

  Function GetUserId_Unsafe() As Integer
    Dim userId As Integer = 0
    Dim conn As ADODB.Connection
    Dim rs As ADODB.Recordset
    
    Dim userName As String 
    userName = txtUsernameTextbox.Text
    Dim sql As String 
    sql = "SELECT [UserID] FROM [AppUsers] WHERE [UserName] = '" & userName & "' " 
    
    On Error Goto Error_Handler
    
    Set conn = GetConnection()
    Set rs = conn.Execute(sql)
    
    userId = rs("UserId")

    rs.Close
    Set rs = Nothing 
    conn.Close
    Set conn = Nothing
                
    GetUserId_Unsafe = userId
    Exit Function 
    
    Error_Handler:
      If Not rs Is Nothing Then  
        If rs.State = adStateOpen Then rs.Close  
      End If  
      Set rs = Nothing  

      If Not conn Is Nothing Then  
          If conn.State = adStateOpen Then conn.Close  
      End If  
      Set conn = Nothing  

      Call HandleExceptions Err.Number, Err.Description
  End Function

End Module