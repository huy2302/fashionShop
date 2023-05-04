
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=THUY092\THUYDEV;Database=shop;User Id=sa;Password=123"

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

Response.write "id="&id&" name="&name&" desc="&desc&" brand="&brand&" species="&species&" price="&price

sql = "insert into product values("&id&", '"&name&"', '"&desc&"', 1, '"&species&"', '"&price&"')"
Conn.Execute sql 

sql = "insert into brand values ("&id&", "&id&", '"&brand&"')"
Conn.Execute sql 

Response.ContentType = "text/html"
%>


