<!-- #include file="../connect.asp" --> 
<%
Dim sql

' id = Request.QueryString("id")
name = Request.QueryString("name")
brand = Request.QueryString("brand")
desc = Request.QueryString("desc")
species = Request.QueryString("species")
price = Request.QueryString("price")

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

' sql = "insert into discount values ((select max(ID_product) as id from product), (select max(ID_product) as id from product), '', '', 0)"
' Conn.Execute sql

' Response.ContentType = "text/html"
%>


