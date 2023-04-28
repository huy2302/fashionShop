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
    .m-10-20 {
        margin: 10px 20px;
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
                <div class="col-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title">Add a new product</h4>
                  <p class="card-description">
                    Enter information for new products
                  </p>
                  <form class="forms-sample">
                    <div class="form-group">
                        <label for="exampleInputName1">Name product</label>
                        <input name="nameProduct" type="text" class="form-control" id="exampleInputName1" placeholder="Name product">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail3">Description</label>
                        <input name="description" type="text" class="form-control" id="exampleInputEmail3" placeholder="Description">
                    </div>
                    <div class="form-group">
                        <label for="exampleSelectGender">Species</label>
                        <select class="form-control" id="exampleSelectGender">
                            <option>Dresses</option>
                            <option>Bodysuits</option>
                            <option>Hoodies & Sweats</option>
                            <option>Jackets & Coats</option>
                            <option>Jeans</option>
                            <option>Pants & Leggings</option>
                            <option>Rompers & Jumpsuits</option>
                            <option>Shirts & Blouses</option>
                            <option>Shirts</option>
                            <option>Sweaters & Knits</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword4">Price</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-primary text-white">$</span>
                            </div>
                            <input type="number" class="form-control" aria-label="Amount (to the nearest dollar)">
                            <div class="input-group-append">
                                <span class="input-group-text">.00</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail3">Color</label>
                        <div class="input-group">
                            <input id="add-color-input" type="text" class="form-control" placeholder="Add a color for product" aria-label="Recipient's username">
                            <div class="input-group-append">
                                <button id="add-color-btn" style="border-radius: 2px;" class="btn btn-sm btn-primary" type="button">Add</button>
                            </div>
                        </div>  
                    </div>
                    <div id="add-size">
                        
                    </div>
                    <!-- <div class="form-group">
                        <label for="exampleSelectGender">Gender</label>
                        <select class="form-control" id="exampleSelectGender">
                            <option>Dresses</option>
                            <option>Bodysuits</option>
                            <option>Hoodies & Sweats</option>
                            <option>Bodysuits</option>
                            <option>Bodysuits</option>
                            <option>Bodysuits</option>
                            <option>Bodysuits</option>
                        </select>
                    </div> -->
                    <div class="form-group">
                      <label>File upload</label>
                      <input type="file" name="img[]" class="file-upload-default">
                      <div class="input-group col-xs-12">
                        <input type="text" class="form-control file-upload-info" disabled placeholder="Upload Image">
                        <span class="input-group-append">
                            <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                        </span>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="exampleInputCity1">City</label>
                      <input type="text" class="form-control" id="exampleInputCity1" placeholder="Location">
                    </div>
                    <div class="form-group">
                      <label for="exampleTextarea1">Textarea</label>
                      <textarea class="form-control" id="exampleTextarea1" rows="4"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary me-2">Submit</button>
                    <button class="btn btn-light">Cancel</button>
                  </form>
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
    <script>
        const addColorBtn = document.getElementById('add-color-btn');
        const addColorInput = document.getElementById('add-color-input');
        const addSize = document.getElementById('add-size');
        const colorSizeName = document.querySelectorAll('.color-size-name');
        addColorBtn.addEventListener('click', () => {
            if (addColorInput.value == '') {
                alert('Please enter the color of the product!');
            } else {
                const str = addColorInput.value
                const strUpperCase = str.charAt(0).toUpperCase() + str.slice(1);
                addSize.innerHTML += `
                <div class="form-group" style="display: inline-flex; align-items: center;">
                    <label class="color-size-name" style="min-width: 10em;" for="exampleInputPassword4">${strUpperCase}</label>
                    <div class="form-check m-10-20">
                    <label class="form-check-label">
                        <input type="checkbox" class="form-check-input">
                        S
                        <i class="input-helper"></i>
                    </label>
                    </div>
                    <div class="form-check m-10-20">
                    <label class="form-check-label">
                        <input type="checkbox" class="form-check-input">
                        M
                        <i class="input-helper"></i>
                    </label>
                    </div>
                    <div class="form-check m-10-20">
                    <label class="form-check-label">
                        <input type="checkbox" class="form-check-input">
                        L
                        <i class="input-helper"></i>
                    </label>
                    </div>
                    <div class="form-check m-10-20">
                    <label class="form-check-label">
                        <input type="checkbox" class="form-check-input">
                        XL
                        <i class="input-helper"></i>
                    </label>
                    </div>
                    <div class="form-check m-10-20">
                    <label class="form-check-label">
                        <input type="checkbox" class="form-check-input">
                        XXL
                        <i class="input-helper"></i>
                    </label>
                    </div>
                </div>
                `
            }
        })
    </script>
</body>

</html>