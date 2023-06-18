
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim sql

email = Request.QueryString("email")
password = Request.QueryString("password")


sql = "insert into account values((select max(ID_account) + 1 as id from account), '"&email&"', '"&password&"', 'false')"
Conn.Execute sql 

' Response.ContentType = "text/html"
%>


