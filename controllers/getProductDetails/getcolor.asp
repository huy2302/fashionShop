<!-- #include file="../connect.asp" --> 
<% 

Dim size, sql, result
id = Request.QueryString("id")
size = Request.QueryString("size")
' sql = "SELECT quantity FROM Product WHERE size='" & size & "'"
sql = "select product.ID_product, size, size.ID_size, color, color.ID_color, quantity from product_size_color p join size on size.ID_size = p.ID_size join color on color.ID_color = p.ID_color join product on product.ID_product = p.ID_product where product.ID_product = "&id&" and size.ID_size = " & size & ""
Set result = Server.CreateObject("ADODB.Recordset")
result.Open sql, conn

' Response.ContentType = "text/html"
' Do While Not result.EOF
'   if result("quantity") > 0 then
'     Response.Write "<option value='" & result("ID_color") & "'>" & result("color") & "</option>"
'   else 
'     Response.Write "<option disabled value='" & result("ID_color") & "'>" & result("color") & "</option>"
'   end if
'   result.MoveNext
' Loop

Response.ContentType = "application/json"
Response.Write "["
do while not result.EOF

    Response.Write "{ ""id"": """&result("ID_product")&""", ""size"": """&result("size")&""", ""id_color"": """&result("ID_color")&""", ""color"": """&result("color")&""", ""quantity"": """&result("quantity")&"""},"
        
result.MoveNext
loop
Response.Write    "{ ""id"": ""-1"", ""name"": ""6"" }"
Response.Write "]"
result.Close
%>


