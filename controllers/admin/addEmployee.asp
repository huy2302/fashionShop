
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim sql

firstName = Request.QueryString("firstName")
lastName = Request.QueryString("lastName")
cmnd = Request.QueryString("cmnd")
phone_number = Request.QueryString("phone_number")
birthDay = Request.QueryString("birthDay")
joinOn = Request.QueryString("join")
gender = Request.QueryString("gender")
avt = Request.QueryString("avt")


sql = "INSERT INTO users VALUES ((select max(ID_account) as id from account), (select max(ID_account) as id from account), '"&gender&"', '"&joinOn&"', '"&avt&"', '"&firstName&"', '"&lastName&"', '"&birthDay&"', '"&phone_number&"', '"&cmnd&"')"

Conn.Execute sql 

' Response.ContentType = "text/html"
%>


