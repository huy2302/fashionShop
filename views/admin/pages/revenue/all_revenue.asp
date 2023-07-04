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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
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
    .btn-select {
        min-width: 7em;
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
                    <li style="margin-bottom: 2em;" class="col-lg-8 nav-item d-none d-lg-block">
                        <div id="datepicker-popup" class="input-group date datepicker navbar-date-picker">
                        
                        <input id="select_day" type="date" class="form-control">
                        
                        </div>
                    </li>
                    <li style="margin-bottom: 2em;" class="col-lg-4 nav-item d-none d-lg-block">
                        <div id="datepicker-popup" class="">
                          <button type="button" id = "btn-prev" class="btn-select btn btn-outline-success btn-fw">Pre</button>
                          <button type="button" id ="btn-next" class="btn-select btn btn-outline-success btn-fw">Next</button>
                        </div>
                    </li>
                    <li style="margin-bottom: 2em;" class="col-lg-8 nav-item d-none d-lg-block">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="statistics-details d-flex align-items-center justify-content-between">
                                
                                <div>
                                    <p class="statistics-title">Orders for The Week</p>
                                    <h3 class="weekSales rate-percentage">68.8</h3>
                                    <!--<p class="text-danger d-flex"><i class="mdi mdi-menu-down"></i><span>-0.5%</span></p>-->
                                </div>
                                <div class="d-none d-md-block">
                                    <p class="statistics-title">Amount of The Week</p>
                                    <h3 class="weekRevenue rate-percentage">2m:35s</h3>
                                    <!--<p class="text-danger d-flex"><i class="mdi mdi-menu-down"></i><span>-0.5%</span></p>-->
                                </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <div class="col-lg-6 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                <h4 class="card-title">Number of Orders</h4>
                                <canvas id="areaChart" width="381" height="190" style="display: block; height: 152px; width: 305px;" class="chartjs-render-monitor"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                <h4 class="card-title">Revenue</h4>
                                <!--<canvas id="myChart" style="width:100%;max-width:600px"></canvas>
                                -->
                                <<canvas id="areaChartTotal" width="381" height="190" style="display: block; height: 152px; width: 305px;" class="chartjs-render-monitor"></canvas>
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
    <script src="../../vendors/js/vendor.bundle.base.js"></script>
    <!-- endinject -->
    <!-- Plugin js for this page -->
    <script src="../../vendors/chart.js/Chart.min.js"></script>
    <script src="../../vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
    <!-- End plugin js for this page -->
    <!-- inject:js -->
    <script src="../../js/off-canvas.js"></script>
    <script src="../../js/hoverable-collapse.js"></script>
    <script src="../../js/template.js"></script>
    <script src="../../js/settings.js"></script>
    <script src="../../js/todolist.js"></script>
    <!-- endinject -->
    <!-- Custom js for this page-->
    <!-- <script src="../../js/chart.js"></script> -->
    <script src="../../js/chartSale.js"></script>
    <script src="path-to/node_modules/chart.js/dist/Chart.min.js"></script>
    <script>
        // const xValues = [100,200,300,400,500,600,700,800,900,1000];

        // new Chart("myChart", {
        // type: "line",
        // data: {
        //     labels: xValues,
        //     datasets: [{ 
        //         data: [860,1140,1060,1060,1070,1110,1330,2210,7830,2478],
        //         borderColor: "red",
        //         fill: false
        //     }, { 
        //         data: [1600,1700,1700,1900,2000,2700,4000,5000,6000,7000],
        //         borderColor: "green",
        //         fill: false
        //     }, { 
        //         data: [300,700,2000,5000,6000,4000,2000,1000,200,100],
        //         borderColor: "blue",
        //         fill: false
        //     }]
        // },
        // options: {
        //     legend: {display: false}
        // }
        // });
    </script>
</body>

</html>