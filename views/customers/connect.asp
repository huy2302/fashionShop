<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=THUY092\THUYDEV;Database=shop;User Id=sa;Password=123"
connDB.ConnectionString = strConnection
%>