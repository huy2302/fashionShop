<% 'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"
connDB.ConnectionString = strConnection
connDB.Open()

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
                        <div class="card">
                            <div class="card-body">
                            <h4 class="card-title">Hoverable Table</h4>
                            <p class="card-description">
                                Add class <code>.table-hover</code>
                            </p>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                <thead>
                                    <tr>
                                    <th>Campaign Name</th>
                                    <th>Description</th>
                                    <th>Sale</th>
                                    <th>Campaign Start</th>
                                    <th>Campaign End</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                Set cmdPrep = Server.CreateObject("ADODB.Command")
                                cmdPrep.ActiveConnection = connDB
                                cmdPrep.CommandType = 1
                                cmdPrep.Prepared = True
                                cmdPrep.CommandText = "SELECT ID_campaign, nameCampaign, description, status, start_day, end_day, sale_percent, CASE WHEN end_day >= GETDATE() THEN 'Active' ELSE 'Expired' END AS end_sale FROM campaign GROUP BY ID_campaign, nameCampaign, description, status, start_day, end_day, sale_percent;"

                                Set Result = cmdPrep.execute
                                do while not Result.EOF
                                %>
                                    <tr>
                                        <td><%=Result("nameCampaign")%></td>
                                        <td><%=Result("description")%></td>
                                        <td class="text-danger">
                                            <%=Result("sale_percent")%>%
                                        </td>
                                        <td>
                                            <%=Result("start_day")%>
                                        </td>
                                        <td>
                                            <%=Result("end_day")%>
                                        </td>
                                        <td>
                                            <% 
                                            if (Result("end_sale") = "Expired") then
                                                classStatus = "badge-success"
                                                status = "Completed"
                                            end if
                                            if (Result("end_sale") = "Active") then
                                                classStatus = "badge-warning"
                                                status = "In progress"
                                            end if
                                            %>
                                            <label class="badge <%=classStatus%>"><%=status%></label>
                                        </td>
                                        <td>
                                            <% 
                                            if (Result("end_sale") = "Active") then
                                            %>
                                            <a id="<%=Result("ID_campaign")%>" class="btn btn-secondary end_btn">End Sale</a>
                                            <%
                                            end if
                                            %>
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
    var endSaleBtns = document.querySelectorAll('.end_btn');
        endSaleBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                let text = "Confirm to stop selling this product?";
                if (confirm(text) == true) {
                    window.location.href=`/fashionShop/controllers/admin/endCampaign.asp?id=${btn.id}`
                }
            })
        })
    </script>
</body>

</html>