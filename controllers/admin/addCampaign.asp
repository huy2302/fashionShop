<!-- #include file="../connect.asp" --> 
<%

Dim sql

name = Request.QueryString("name")
desc = Request.QueryString("desc")
ID_product = Request.QueryString("ID_product")

name = Replace(name, "_", " ")
desc = Replace(desc, "_", " ")

sqlCount = "select count(campaign.ID_campaign) as id from campaign"
rsCount = Conn.Execute(sqlCount)

if rsCount("id") = "0" then 
    sql = "insert into campaign values (1, '"&name&"', '"&desc&"', '"&ID_product&"')"
    Conn.Execute sql 
else 
    sql = "insert into campaign values ((select max(ID_campaign) + 1 as id from campaign), '"&name&"', '"&desc&"', '"&ID_product&"')"
    Conn.Execute sql 

end if
' Response.ContentType = "text/html"
%>


