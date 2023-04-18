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
    If (NOT IsNull(ID_product) and ID_product <> "") Then
        Dim cmdPrep, Result
        Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "select product.name, size.ID_size, size, color.ID_color, color, quantity from product_size_color p inner join product on product.ID_product = p.ID_product inner join size on size.ID_size = p.ID_size inner join color on color.ID_color = p.ID_color where product.ID_product = "&ID_product&" and size.ID_size = "&ID_size&" and color.ID_color = "&ID_color&""
            Set Result = cmdPrep.execute 
            Response.Write "ID_product: "&ID_product&" ID_size:"&ID_size&" ID_color:"&ID_color
                Response.write "<br>"

            If not Result.EOF then
                ' Response.Write "ID_product: "&ID_product&" ID_size:"&ID_size&" ID_color:"&ID_color
                ' Response.write "<br>"
                
                ' Set dog = Server.CreateObject("Scripting.Dictionary")
                ' sizeColor = Array("cat1", "dog1", 1)
                ' Response.write dog.Exists(1)
                ' dog.Add 1, sizeColor
                ' Response.write dog.Exists(1)
                ' sizeColor = Array("cat2", "dog2", 1)
                ' dog.Add 2, sizeColor
                ' ' ' 'creating a session for my cart
                ' Set Session("dog") = dog
                ' set cat = session("dog")

                ' Response.write "cat: "&cat.Item(1)(2)
                ' Response.write "<br>"

                ' myarrays = cat.Item(1)
                ' myarrays(2) = myarrays(2) + 1
                ' myarrays(2) = myarrays(2) + 1
                ' cat.Item(1) = myarrays
                ' Response.write cat.Item(1)(2)
                ' Response.write cat.Item(2)(2)

                ' ' dim x
                ' ' x = cat.Item(1)(2)+1
                ' ' cat.Item(1)(2) = x
                ' set session("dog") = cat

                ' set shark = session("dog")

                ' Response.write "shark: "&shark.Item(1)(2)
                ' Response.write "<br>"
        
                'ID exits
                'check session exists
                Dim currentCarts, arrays, cc, mycarts, List, sizeColor
                If (NOT IsEmpty(Session("mycarts"))) Then 'neu mycarts ton tai
                    ' true
                    Set currentCarts = Session("mycarts")      
                    ' for i = 0 to 5     
                    ' Response.write currentCarts.Exists(1)

                    ' next
                    dim a
                    a = 0
                    if currentCarts.Exists(ID_product) = true then 'neu ID_product ton tai trong mycarts
                        ' Response.Write("Hien tai: "&currentCarts.Item(ID_product)(2))         
                        ' Response.write "<br>"
                        Dim arrayColor 
                        arrayColor = currentCarts.Item(ID_product)

                        Response.Write "ID_product: "&currentCarts.Exists(ID_product)&", ID_size: "&arrayColor(0)&", ID_color: "&arrayColor(1)&", quantity: "&arrayColor(2)
                        Response.Write "<br>"

                        arrayColor(2) = arrayColor(2) + 1 ' tăng số lượng sản phẩm thêm 1
                        ' Response.Write arrayColor(2)
                        Response.Write "ID_product: "&currentCarts.Exists(ID_product)&", ID_size: "&arrayColor(0)&", ID_color: "&arrayColor(1)&", quantity: "&arrayColor(2)

                        Response.Write "<br>"

                        currentCarts.Item(ID_product) = arrayColor
                  
                        Response.Write("So luong hien tai: "&currentCarts.Item(ID_product)(2))
                        Response.write "<br>"
                    else ' nếu ID_product chưa tồn tại trong Session("mycarts")

                        sizeColor = Array(CInt(Result("ID_size")), CInt(Result("ID_color")), 1)
                        currentCarts.Add ID_product, sizeColor
                        Response.Write "Created product ID = "&ID_product

                    end if 
                    'saving new session value
                    Set Session("mycarts") = currentCarts
                    Response.Write("The Session is exists.")                                      
                Else
                    'lưu Dictionary gồm 4 thuộc tính: 
                    'carts = Server.CreateObject("Scripting.Dictionary")
                    'sizeColor = Array(size, color, quantity)
                    'carts.Add ID_product, sizeColor                 
                    Set mycarts = Server.CreateObject("Scripting.Dictionary")
                    ID_sizee = CInt(Result("ID_size"))
                    ID_colorr = CInt(Result("ID_color"))
                    
                    sizeColor = Array(ID_sizee, ID_colorr, 1)
                    mycarts.Add ID_product, sizeColor
                    'creating a session for my cart
                    Set Session("mycarts") = mycarts
                    Set mycarts = Nothing
                    Response.Write "Created product ID = "&ID_product&"<br>"
                    Response.Write("Session created!")
                End if
                Session("Success") = "The Product has bean added to your cart."
            Else
                Session("Error") = "The Product is not exists, please try again."
            End If

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