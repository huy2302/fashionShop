
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim sql

id = Request.QueryString("id")
password = Request.QueryString("password")


sql = "update account set account.password = "&password&" where account.ID_account = (select ID_account from users where ID_user = "&id&")"
Response.Write "<br>"
Response.Write sql

Conn.Execute sql 

Response.ContentType = "text/html"
%>



