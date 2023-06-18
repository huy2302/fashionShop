<!--#include file="connect.asp"-->
<%
if (not IsEmpty(Session("ID_user"))) then 
if not IsEmpty(Session("ID_user")) then 
    
else 

end if
sql = "select cart.ID_product, product.name, cart.ID_size, size.size, cart.ID_color, color.color, brand, product.price, cart.quantity, link1, sale_percent, end_day from cart inner join product_size_color p on cart.ID_product = p.ID_product inner join size on cart.ID_size = size.ID_size inner join color on cart.ID_color = color.ID_color inner join product on product.ID_product = cart.ID_product inner join brand on brand.ID_product = cart.ID_product inner join imageProduct on imageProduct.ID_product = cart.ID_product inner join discount on discount.ID_product = cart.ID_product where cart.ID_user = "&Session("ID_user")&" group by cart.ID_product, product.name, cart.ID_size, size.size, cart.ID_color, color.color, brand, product.price, cart.quantity, link1, sale_percent, end_day"

Set result = Conn.execute(sql)

Response.ContentType = "application/json"
Response.Write "["
do while not result.EOF
    price = CInt(result("price"))
    quantity = CInt(result("quantity"))
    percent = CInt(result("sale_percent"))

    ' tạo biến currentDate lấy ra ngày hiện tại
    ' so sánh với ngày hết hạn sale để tính giá tiền
    currentDate_cart = Date()

    datee = FormatDateTime(result("end_day"),2)

    if (CStr(datee) < CStr(currentDate_cart)) then
        percent = 0
    end if

    Response.Write "{ ""id"": """&result("ID_product")&""", ""id_size"": """&result("ID_size")&""", ""id_color"": """&result("ID_color")&""", ""name"": """&result("name")&""", ""size"": """&result("size")&""", ""color"": """&result("color")&""", ""brand"": """&result("brand")&""", ""price"": """&result("price")&""", ""quantity"": """&result("quantity")&""", ""sale_percent"": """&percent&""", ""end_day"": """&result("end_day")&""", ""link1"": """&result("link1")&"""},"
        
result.MoveNext
loop
Response.Write    "{ ""id"": ""-1"", ""name"": ""6"" }"
Response.Write "]"
end if
%>
