<!-- #include file="aspuploader/include_aspuploader.asp" -->

<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

sqlCount = "select max(ID_campaign) + 1 as id from campaign"
rsCount = Conn.Execute(sqlCount)

ID_campaign = rsCount("id")

if not IsNull(ID_campaign) then 
    ' response.write ID_campaign 
else 
    ID_campaign = 1
    ' response.write ID_campaign
end if
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
    .imgUp {
        width: 5em;
        margin-right: 1em;
        object-fit: cover;
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
                    <form class="forms-sample" method="POST" >
                        <div class="form-group">
                            <label for="exampleInputName1">Campaign Name</label>
                            <input name="CampaignName" type="text" class="form-control" id="exampleInputName1" placeholder="Campaign Name" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail3">Description</label>
                            <input name="description" type="text" class="form-control" id="exampleInputEmail3" placeholder="Description" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputName1">Sale Percent</label>
                            <input name="salePercent" type="number" class="form-control" id="exampleInputName1" placeholder="Enter sale percent" required>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label for="exampleInputName1">Start Day</label>
                                <input name="startDay" type="date" class="form-control" id="exampleInputName1" placeholder="Brand product" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="exampleInputName1">End Day</label>
                                <input name="endDay" type="date" class="form-control" id="exampleInputName1" placeholder="Brand product" required>
                            </div>
                        </div>
                        <div class="form-group ">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>
                                                Choose
                                            </th>
                                            <th>
                                                ID
                                            </th>
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
                                                Price
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="list-product">

                                    </tbody>
                                    </table>
                                </div>
                            </div>
                        
                            <a class="submitAdd btn btn-primary me-2">Add</a>
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
        var getTotal = function (){
            $.ajax({
                url: '/fashionShop/controllers/admin/getAllProduct.asp',
                // data: data,
                dataType: 'json',
                success: function (response) {
                    
                    document.getElementById('list-product').innerHTML = "";
                    response.forEach(element => {
                        if (element.id == -1) return
                        document.getElementById('list-product').innerHTML += `
                        <tr>    
                            <td class="py-1">
                                <input type="checkbox" class="list-check" value="${element.ID_product}">
                            </td>
                            <td>
                                ${element.ID_product}
                            </td>
                            <td class="py-1">
                                <img style="object-fit: contain;" src="../../../../resources/imgProduct/${element.link1}" alt="image">
                            </td>
                            <td>
                                ${element.name}
                            </td>
                            <td>
                                ${element.brand}
                            </td>
                            <td>
                                $${element.price}.00
                            </td>
                        </tr>
                        `;
                    });
                },
                error: function (response){
                    alert('Lỗi AJAX');
                }
            });
        }
        getTotal()
        const changeCheckbox = () => {
            var listCheck = document.querySelectorAll('.list-check');
            var listChecked = []
            listCheck.forEach(element => {
                if (element.checked) {
                    listChecked.push(element.value);
                }
            })
            return listChecked
        }
        const checkEmptyForm = () => {
            CampaignName = document.querySelector('input[name="CampaignName"]').value;
            description = document.querySelector('input[name="description"]').value;

            salePercent = document.querySelector('input[name="salePercent"]').value;
            startDay = document.querySelector('input[name="startDay"]').value;
            endDay = document.querySelector('input[name="endDay"]').value;

            CampaignName = CampaignName.replace(/ /g, "_");
            description = description.replace(/ /g, "_");
            
            var listChecked = changeCheckbox();
            if (listChecked.length > 0) {
                // update sale cho những sản phẩm nằm trong chiến dịch sale
                listChecked.forEach(element => {
                    // add bảng campaign
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.open("GET", "/fashionShop/controllers/admin/addCampaign.asp?id=<%=ID_campaign%>&name=" + CampaignName + "&desc="+description + "&ID_product="+element + "&start="+startDay + "&end="+endDay + "&sale="+salePercent, true);
                    
                    xmlhttp.send();
                    
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.open("GET", "/fashionShop/controllers/admin/editSalePercent.asp?id_product=" + element + "&start="+startDay + "&end="+endDay + "&sale="+salePercent, true);
                    
                    xmlhttp.send();
                })

            }
        }
        const submitBtn = document.querySelector('.submitAdd');
        submitBtn.addEventListener('click', () => {
            checkEmptyForm();
        })
    </script>
</body>

</html>