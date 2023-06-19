
<!-- #include file="../connect.asp" --> 
<%

sql = "SELECT product.name, product.ID_product, new, sale_percent, brand, price, link1, link2 FROM product inner join discount on discount.ID_product = product.ID_product inner join brand on product.ID_product = brand.ID_product inner join imageProduct on product.ID_product = imageProduct.ID_product GROUP BY product.name, product.ID_product, new, sale_percent, brand, price, link1, link2"

Set result = Conn.execute(sql)

Response.ContentType = "application/json"
Response.Write "["
do while not result.EOF

    Response.Write "{ ""ID_product"": """&result("ID_product")&""", ""name"": """&result("name")&""", ""new"": """&result("new")&""", ""sale_percent"": """&result("sale_percent")&""", ""brand"": """&result("brand")&""", ""price"": """&result("price")&""", ""link1"": """&result("link1")&""", ""link2"": """&result("link2")&"""},"
    
result.MoveNext
loop
Response.Write    "{ ""id"": ""-1"", ""name"": ""6"" }"
Response.Write "]"
' end if
%>