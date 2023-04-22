<!--#include file="connect.asp"-->

<%    
    'Lay ve IDProduct
    Dim ID_product, ID_size, ID_color
    ID_product = Request.QueryString("id")
    ID_size = Request.QueryString("size")
    ID_color = Request.QueryString("color")
    Response.Write "ID_product: "&ID_product&" ID_size:"&ID_size&" ID_color:"&ID_color
    Response.Write "<br/>"

    ' Do Something...
    If (NOT IsNull(ID_product) and NOT IsEmpty(Session("ID_user"))) Then
        Dim cmdPrep, Result
        Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "select product.ID_product, product.name, size.ID_size, size, color.ID_color, color, cart.quantity from cart inner join product_size_color p on p.ID_product = cart.ID_product inner join product on product.ID_product = cart.ID_product inner join size on size.ID_size = cart.ID_size inner join color on color.ID_color = cart.ID_color where product.ID_product = "&ID_product&" and size.ID_size = "&ID_size&" and color.ID_color = "&ID_color&" group by product.ID_product, product.name, size.ID_size, size, color.ID_color, color, cart.quantity"
            Set Result = cmdPrep.execute 
            Response.write "<br>"

            Set Conn = Server.CreateObject("ADODB.Connection")
            Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"
            
            If Result.EOF then
                sql = "insert into cart (ID_user, ID_product, ID_size, ID_color, quantity) values ("&Session("ID_user")&", "&ID_product&", "&ID_size&", "&ID_color&", 1)"
                Conn.Execute sql
            end if

            Do While Not Result.EOF
                IF (CInt(ID_product) = CInt(Result("ID_product")) and CInt(ID_size) = CInt(Result("ID_size")) and CInt(ID_color) = CInt(Result("ID_color")) ) then
                    sql = "update cart set quantity = ((select quantity from cart where cart.ID_product = "&Result("ID_product")&" and cart.ID_size = "&Result("ID_size")&" and cart.ID_color = "&Result("ID_color")&") + 1) where cart.ID_product = "&Result("ID_product")&" and cart.ID_size = "&Result("ID_size")&" and cart.ID_color = "&Result("ID_color")&""
                    Conn.Execute sql
                    Session("Success") = "The Product has bean added to your cart."
                END IF
                Result.MoveNext
            Loop
            Conn.close()
                ' if (ID_product = Result("ID_product"))
                'ID exits
                ' Response.Write "ID_product: "&Result("ID_product")&" ID_size:"&Result("ID_size")&" ID_color:"&Result("ID_color")&", Quantity: "&Result("quantity")

                'check session exists
                ' Dim currentCarts, arrays, cc, mycarts, List, sizeColor
                ' If (NOT IsEmpty(Session("mycarts"))) Then 'neu mycarts ton tai

                ' Response.Write "ID_product: "&CInt(Result("ID_product"))&" ID_size:"&CInt(Result("ID_size"))&" ID_color:"&CInt(Result("ID_color"))
                ' Response.write "<br>"
 

                ' sql = "update cart set quantity = ((select quantity from cart where cart.ID_product = 1 and cart.ID_size = 1 and cart.ID_color = 1) + 1) where cart.ID_product = 1 and cart.ID_size = 1 and cart.ID_color = 1"


                
                ' true
                ' Set currentCarts = Session("mycarts")      
                ' if currentCarts.Exists(ID_product) = true then 'neu ID_product ton tai trong mycarts
                '     Dim arrayColor 
                '     arrayColor = currentCarts.Item(ID_product)

                '     Response.Write "ID_product: "&currentCarts.Exists(ID_product)&", ID_size: "&arrayColor(0)&", ID_color: "&arrayColor(1)&", quantity: "&arrayColor(2)
                '     Response.Write "<br>"

                '     arrayColor(2) = arrayColor(2) + 1 ' tăng số lượng sản phẩm thêm 1
                '     Response.Write "ID_product: "&currentCarts.Exists(ID_product)&", ID_size: "&arrayColor(0)&", ID_color: "&arrayColor(1)&", quantity: "&arrayColor(2)

                '     Response.Write "<br>"

                '     currentCarts.Item(ID_product) = arrayColor
            
                '     Response.Write("So luong hien tai: "&currentCarts.Item(ID_product)(2))
                '     Response.write "<br>"
                ' else ' nếu ID_product chưa tồn tại trong Session("mycarts")

                '     sizeColor = Array(CInt(Result("ID_size")), CInt(Result("ID_color")), 1)
                '     currentCarts.Add ID_product, sizeColor
                '     Response.Write "Created product ID = "&ID_product

                ' end if 
                'saving new session value
                ' Set Session("mycarts") = currentCarts
                Response.Write("The Session is exists.")   
            '     result.MoveNext
            ' Loop

            ' Set Result = Nothing
            Result.Close()
            connDB.Close()

        '    Response.redirect("products.asp")            
    End if   

    'Dim mycarts
   'lay ve danh sach ID trong gio hang
    'Su dung dictionary object de luu tru id product kem theo so luong
    '1. De an tam: hay kiem tra truoc xem id product co ton tai trong table product hay khong
    '- Neu ton tai thi:
    '   - Kiem tra neu session carts da ton tai thi: Kiem tra id product da ton tai trong carts hay chua, neu da ton tai thi quantity++; Neu chua thi add
    '   - Neu session chua ton tai thi tao dictionary add id va quantity vao sau do tao session
    '- Neu ip product khong con ton tai trong table product thi thong bao.
    'Dim carts
    'Set mycarts = Server.CreateObject("Scripting.Dictionary")
    'carts.Add idproduct, quantity
  ' mycart = Session("s_Carts")
   ' If IsArray(mycart) then
    ' Response.Write(LBound(mycart)&":--->"&UBound(mycart))
    'Tao ra gio hang moi de tiep tuc mua
   ' Dim newCart
    'Redim newCart(UBound(mycart)+1)
    'copy du lieu sang gio hang co kich thuoc tang them 1
   ' for i=LBound(mycart) to UBound(mycart)
    'newCart(i) = mycart(i)
   ' Next
    'chon them 1 san pham va bo sung vao gio hang
    'newCart(UBound(mycart)+1)=idProduct
    'luu gio hang moi vao session
   ' Session("s_Carts") = newCart
    'Response.redirect("products.asp")
%>