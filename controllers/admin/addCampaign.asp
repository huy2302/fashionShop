<!-- #include file="../connect.asp" --> 
<%

Dim sql

id = Request.QueryString("id")
name = Request.QueryString("name")
desc = Request.QueryString("desc")
ID_product = Request.QueryString("ID_product")
startDay = Request.QueryString("start")
endDay = Request.QueryString("end")
sale = Request.QueryString("sale")

name = Replace(name, "_", " ")
desc = Replace(desc, "_", " ")
response.write "insert into campaign values ("&id&", '"&name&"', '"&desc&"', '"&ID_product&"', 'In progress', "&sale&", '"&startDay&"', '"&endDay&"')"

sqlCount = "select count(campaign.ID_campaign) as id from campaign"
rsCount = Conn.Execute(sqlCount)

if rsCount("id") = "0" then 
    sql = "insert into campaign values (1, '"&name&"', '"&desc&"', '"&ID_product&"', 'In progress', "&sale&", '"&startDay&"', '"&endDay&"')"
    Conn.Execute sql 
else 
    sql = "insert into campaign values ("&id&", '"&name&"', '"&desc&"', '"&ID_product&"', 'In progress', "&sale&", '"&startDay&"', '"&endDay&"')"
    Conn.Execute sql 

end if
' Response.ContentType = "text/html"
%>


