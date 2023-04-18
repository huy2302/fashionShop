<!--#include file="connect.asp"-->
<%
'lay ve danh sach product theo id trong my cart
Dim idList, mycarts, totalProduct, subtotal, statusViews, statusButtons, rs
If (NOT IsEmpty(Session("mycarts"))) Then
  statusViews = "d-none"
  statusButtons = "d-block"
' true
	Set mycarts = Session("mycarts")
	idList = ""
	totalProduct=mycarts.Count    
	For Each List In mycarts.Keys
		If (idList="") Then
' true
			idList = List
		Else
			idList = idList & "," & List
		End if                               
	Next
	Dim sqlString
	sqlString = "Select * from SANPHAM where masp IN (" & idList &")"
	connDB.Open()
	set rs = connDB.execute(sqlString)
	calSubtotal(rs)

  Else
    'Session empty
    statusViews = "d-block"
    statusButtons = "d-none"
    totalProduct=0
  End If
  Sub calSubtotal(rs)
' Do Something...
		subtotal = 0
		do while not rs.EOF
			subtotal = subtotal + Clng(mycarts.Item(CStr(rs("masp")))) * CDbl(CStr(rs("giasp")))
			rs.MoveNext
		loop
		rs.MoveFirst
	End Sub
  Sub defineItems(v)
    If (v>1) Then
      Response.Write(" Items")
    Else
      Response.Write(" Item")
    End If
  End Sub
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carts</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">

</head>
<body>
<!-- #include file="header.asp" -->
<section class="h-100 h-custom" style="background-color: #eee;">
  <div class="container py-2 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12">
        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
          <div class="card-body p-0">
            <div class="row g-0">
              <div class="col-lg-8">
                <div class="p-5">
                  <div class="d-flex justify-content-between align-items-center mb-5">
                    <h1 class="fw-bold mb-0 text-black">Shopping Cart</h1>
                    <h6 class="mb-0 text-muted"><%= totalProduct %> <%call defineItems(totalProduct) %></h6>
                  </div>
                  <form action="removecart.asp" method=post>
                  <hr class="my-4">
                  <h5 class="mt-3 text-center text-body-secondary <%= statusViews %>">You have no products added in your shopping cart.</h5>
                <%
                If (totalProduct<>0) Then
                do while not rs.EOF
                %>
                  <div class="row mb-4 d-flex justify-content-between align-items-center">
                    <div class="col-md-2 col-lg-2 col-xl-2">
                      <img
                        src="https://mdbcdn.b-cdn.net/img/Photos/Horizontal/E-commerce/Products/img%20(4).webp"
                        class="img-fluid rounded-3" alt="Cotton T-shirt">
                    </div>
                    <div class="col-md-3 col-lg-3 col-xl-3">
                      <h6 class="text-muted"><%= rs("tensp")%></h6>
                      <h6 class="text-black mb-0"><%= rs("mota")%></h6>
                    </div>
                    <div class="col-md-3 col-lg-3 col-xl-2 d-flex">
                      <button class="btn btn-link px-2"
                        onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
                        <i class="fas fa-minus"></i>
                      </button>

                      <input id="form1" min="0" name="quantity" value="<%
                        Dim id
                        id  = CStr(rs("masp"))
                        Response.Write(mycarts.Item(id))                                     
                        %>" type="number"
                        class="form-control form-control-sm" />

                      <button class="btn btn-link px-2"
                        onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
                        <i class="fas fa-plus"></i>
                      </button>
                    </div>
                    <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                      <h6 class="mb-0">$ <%= rs("giasp")%></h6>
                    </div>
                    <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                    
                      <a href="removecart.asp?id=<%= rs("masp")%>" class="text-muted"><i class="fas fa-times"></i></a>
                    </div>
                  </div>

                  <hr class="my-4">
<%
                rs.MoveNext
                loop
                'phuc vu cho viec update subtotal
                rs.MoveFirst
                End If
                %> 
                
                  <div class="row pt-2">
                    <h6 class="mb-0 col-lg-10 pt-3"><a href="products.asp" class="text-body"><i
                          class="fas fa-long-arrow-alt-left me-2"></i>Back to shop</a></h6>
                          <input type="submit" name="update" value="Update" class="btn btn-warning btn-block btn-lg text-white col-lg-2 <%= statusButtons %>"
                    data-mdb-ripple-color="dark"/>
                  </div>
                </form>
                </div>
              </div>
              <div class="col-lg-4 bg-secondary-subtle <%= statusButtons %>">
                <div class="p-5">
                  <h3 class="fw-bold mb-5 mt-2 pt-1">Summary</h3>
                  <hr class="my-4">

                  <div class="d-flex justify-content-between mb-4">
                    <h5 class="text-uppercase"><%= totalProduct %> <%call defineItems(totalProduct) %></h5>
                    <h5>$ <%= subtotal%></h5>
                  </div>

                  <h5 class="text-uppercase mb-3">Shipping</h5>

                  <div class="mb-4 pb-2">
                    <select class="select">
                      <option value="1">Standard-Delivery- $5</option>
                      <option value="2">Two</option>
                      <option value="3">Three</option>
                      <option value="4">Four</option>
                    </select>
                  </div>

                  <h5 class="text-uppercase mb-3">Give code</h5>

                  <div class="mb-5">
                    <div class="form-outline">
                      <input type="text" id="form3Examplea2" class="form-control form-control-lg" />
                      <label class="form-label" for="form3Examplea2">Enter your code</label>
                    </div>
                  </div>

                  <hr class="my-4">

                  <div class="d-flex justify-content-between mb-5">
                    <h5 class="text-uppercase">Total price</h5>
                    <h5>$ <%= subtotal %></h5>
                  </div>
                  <div class="row">
                    <button type="button" class="btn btn-success btn-lg"
                      data-mdb-ripple-color="dark">Purchase</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

 <!--#include file="footer.asp"-->
</body>

</html>
