<!--#include file="connect.asp"-->
<% 
if NOT IsEmpty(Session("ID_user")) then
    Set RScolorSize = Server.CreateObject("ADODB.Recordset")
    sql = "select cart.ID_product, product.name, cart.ID_size, size.size, cart.ID_color, color.color, brand, product.price, cart.quantity, link1, sale_percent, end_day from cart inner join product_size_color p on cart.ID_product = p.ID_product inner join size on cart.ID_size = size.ID_size inner join color on cart.ID_color = color.ID_color inner join product on product.ID_product = cart.ID_product inner join brand on brand.ID_product = cart.ID_product inner join imageProduct on imageProduct.ID_product = cart.ID_product inner join discount on discount.ID_product = cart.ID_product where cart.ID_user = "&Session("ID_user")&" group by cart.ID_product, product.name, cart.ID_size, size.size, cart.ID_color, color.color, brand, product.price, cart.quantity, link1, sale_percent, end_day"

    RScolorSize.Open sql, conn
    do while not RScolorSize.EOF
        totalProduct = totalProduct + CDbl(RScolorSize("price")) * CDbl(RScolorSize("quantity"))
        totalSale = totalSale + CDbl(RScolorSize("price")) * CDbl(RScolorSize("quantity")) * (100 - CDbl(RScolorSize("sale_percent")))/100   
        priceSale = CDbl(RScolorSize("price")) * (100 - CDbl(RScolorSize("sale_percent")))/100

        price = CInt(RScolorSize("price"))
        quantity = CInt(RScolorSize("quantity"))
        percent = CInt(RScolorSize("sale_percent"))

        ' tạo biến currentDate lấy ra ngày hiện tại
        ' so sánh với ngày hết hạn sale để tính giá tiền
        currentDate_cart = Date()

        datee = FormatDateTime(RScolorSize("end_day"),2)

        if (CStr(datee) < CStr(currentDate_cart)) then
            percent = 0
        end if

        ' tính giá tổng đơn hàng
        subtotal_sale = (price * (100 - percent))/100 * quantity
        subtotal = price * quantity
        total = total + subtotal
        total_sale = total_sale + subtotal_sale
    RScolorSize.MoveNext
loop
end if

Response.ContentType = "application/json"
Response.Write "{""subtotal"": """&total&""", ""saleoff"": """&total - total_sale&""", ""total"": """&total_sale&"""}"
%>