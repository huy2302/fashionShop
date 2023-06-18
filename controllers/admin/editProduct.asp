<!-- #include file="../connect.asp" --> 
<%

Dim sql

id = Request.QueryString("id")
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

sql = "update product set name = '"&name&"', description = '"&desc&"', species = '"&species&"', price = '"&price&"' where ID_product = "&id
Conn.Execute sql 

sql = "update brand set brand = '"&brand&"' where ID_product = "&id
Conn.Execute sql 


' Response.ContentType = "text/html"
%>


