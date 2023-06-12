
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim sql

' id = Request.QueryString("id")
firstName = Request.QueryString("firstName")
lastName = Request.QueryString("lastName")
cmnd = Request.QueryString("desc")
phone_number = Request.QueryString("phone_number")
birthDay = Request.QueryString("birthDay")
join = Request.QueryString("join")
gender = Request.QueryString("gender")

name = Replace(name, "_", " ")
brand = Replace(brand, "_", " ")
desc = Replace(desc, "_", " ")
species = Replace(species, "_", " ")
species = Replace(species, "<>", "&")
dim id

sql = "insert into product values((select max(ID_product) + 1 as id from product), '"&name&"', '"&desc&"', 1, '"&species&"', '"&price&"')"
Conn.Execute sql 

sql = "insert into brand values ((select max(ID_product) as id from product), ((select max(ID_product) as id from product)), '"&brand&"')"
Conn.Execute sql 

sql = "insert into discount values ((select max(ID_product) as id from product), (select max(ID_product) as id from product), '', '', 0)"
Conn.Execute sql

' Response.ContentType = "text/html"
%>


