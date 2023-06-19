<!--#include file="connect.asp"-->
<%

Dim nameProduct
nameProduct = Request.QueryString("ID_product")
'Rest of your code here'
 
sql = "SELECT product.*, brand, link1, sale_percent, end_day FROM product join discount on discount.ID_product = product.ID_product join brand on brand.ID_product = product.ID_product join imageProduct on imageProduct.ID_product = product.ID_product WHERE product.name LIKE '%"&nameProduct&"%'"

Set result = Conn.execute(sql)

Response.ContentType = "application/json"
Response.Write "["
do while not result.EOF
    percent = CInt(Result("sale_percent"))

    Dim currentDate
    currentDate = Date()

    Dim datee
    datee = FormatDateTime(Result("end_day"),2)

    if (CStr(datee) < CStr(currentDate)) then
        percent = 0
    end if

    if (percent > 0) then 
        priceSale = CInt(Result("price")) - CInt(Result("price")) * percent / 100
    else 
        priceSale = CInt(Result("price"))
    end if

    Response.Write "{ ""id"": """&result("ID_product")&""", ""name"": """&result("name")&""", ""brand"": """&result("brand")&""", ""species"": """&result("species")&""", ""price"": """&result("price")&""", ""price_sale"": """&priceSale&""", ""image"": """&result("link1")&"""},"
        
result.MoveNext
loop
Response.Write    "{ ""id"": ""-1"", ""name"": ""6"" }"
Response.Write "]"
' end if
%>