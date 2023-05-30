<% 'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"
connDB.ConnectionString = strConnection
connDB.Open()

%>
<%
' ham lam tron so nguyen 
function Ceil(Number) Ceil=Int(Number) 
if Ceil<>Number Then
  Ceil = Ceil + 1
  end if
  end function

  function checkPage(cond, ret)
  if cond=true then
  Response.write ret
  else
  Response.write ""
  end if
  end function
  ' trang hien tai
  page = Request.QueryString("page")
  limit = 9

  if (trim(page) = "") or (isnull(page)) then
  page = 1
  end if

  offset = (Clng(page) * Clng(limit)) - Clng(limit)

  strSQL = "SELECT COUNT(ID_product) AS count FROM product"
  Set CountResult = connDB.execute(strSQL)

  totalRows = CLng(CountResult("count"))

  Set CountResult = Nothing
  ' lay ve tong so trang
  pages = Ceil(totalRows/limit)
  %>

  <!DOCTYPE html>
  <html lang="en">

  <head>
    <!-- <link rel="stylesheet" href="./css/modal.css"> -->
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Star Admin2 </title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="../../vendors/feather/feather.css">
    <link rel="stylesheet" href="../../vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="../../vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="../../vendors/typicons/typicons.css">
    <link rel="stylesheet" href="../../vendors/simple-line-icons/css/simple-line-icons.css">
    <link rel="stylesheet" href="../../vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link rel="stylesheet" href="../../css/vertical-layout-light/style.css">
    <!-- endinject -->
    <link rel="shortcut icon" href="../../images/favicon.png" />
  </head>
  <style>
    .swal2-confirm.swal2-styled {
        background-color: rgb(48, 133, 214) !important;
        color: #fff !important;
        font-weight: 400 !important;
    }
    .table td img {
        object-fit: contain;
    }
    .end_btn {
        color: #ffffff !important;
        background: #ff8100 !important;
    }
  </style>

  <body>
    <div class="container-scroller">
      <!-- partial:partials/_navbar.html -->

      <!-- #include file="../../partials/_header.asp" --> 

      <!-- partial -->
      <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_settings-panel.html -->

        <!-- #include file="../../partials/_settings-panel.asp" -->

        <!-- partial -->

        <!-- #include file="../../partials/_sidebar.asp" -->

        <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
            <div class="row">
              <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">List Products</h4>
                    <div class="table-responsive">
                      <table class="table table-striped">
                        <thead>
                          <tr>
                            <th>
                              Product
                            </th>
                            <th>
                              Name
                            </th>
                            <th>
                              Brand
                            </th>
                            <th>
                              Sale percent
                            </th>
                            <th>
                              Price
                            </th>
                            <th>
                              End sale
                            </th>
                            <th>
                              Action
                            </th>
                          </tr>
                        </thead>
                        <tbody>
                          <%
                          Set cmdPrep = Server.CreateObject("ADODB.Command")
                          cmdPrep.ActiveConnection = connDB
                          cmdPrep.CommandType = 1
                          cmdPrep.Prepared = True
                          cmdPrep.CommandText = "SELECT product.name, product.ID_product, new, sale_percent, end_day, brand, price, link1, link2 FROM product inner join discount on discount.ID_product = product.ID_product inner join brand on product.ID_product = brand.ID_product inner join imageProduct on product.ID_product = imageProduct.ID_product where sale_percent > 0 and end_day + 1 > CURRENT_TIMESTAMP GROUP BY product.name, product.ID_product, new, sale_percent, end_day, brand, price, link1, link2 ORDER BY ID_product OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                          cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                          cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)

                          Set Result = cmdPrep.execute
                          do while not Result.EOF
                          %>
                          <tr>
                            <td class="py-1">
                                <img src="/fashionShop/resources/imgProduct/<%=Result("link1")%>" alt="image"/>
                            </td>
                            <td>
                                <%=Result("name")%>
                            </td>
                            <td>
                                <!--<div class="progress">
                                    <div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>-->
                                <%=Result("brand")%>
                            </td>
                            <td>
                                <%=Result("sale_percent")%>%
                            </td>
                            <td>
                                $<%=Result("price")%>.00
                            </td>
                            <td>
                                <%
                                dim endDate
                                endDate = Result("end_day")
                                Dim day, month, year
                                day = DatePart("d", endDate)
                                month = DatePart("m", endDate)
                                year = DatePart("yyyy", endDate)

                                response.write day&"/"&month&"/"&year
                                %>
                            </td>
                            <td>
                                <a href="/fashionShop/controllers/admin/endSale.asp?id=<%=Result("id_product")%>" class="btn btn-secondary end_btn">End Sale</a>
                            </td>
                            </tr>
                            <%
                                Result.MoveNext
                                loop
                            %>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
        <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Premium <a href="https://www.bootstrapdash.com/" target="_blank">Bootstrap admin template</a> from BootstrapDash.</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Copyright © 2021. All rights reserved.</span>
          </div>
        </footer>
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
    </div>
  </div>
    <!-- container-scroller -->
    <!-- #include file="../../js/mainJs.asp" -->

</body>

</html>