<% 'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"
connDB.ConnectionString = strConnection
connDB.Open()

ID_employeeEdit = Session("ID_Employee")
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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
  .file-upload-info {
    padding-bottom: 25px;
  }
  .pass-error {
    display: flex;
    flex-direction: column;
    padding-left: 1em;
  }
  .pass-error span {
    font-size: 14px;
  }
  .pass-error .pass-suc {
    color: #00cc1f;
  }
  .pass-error .pass-err {
    color: #ff0700;
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
      <!-- #include file="../../partials/_settings-panel.asp" -->


      <!-- #include file="../../partials/_sidebar.asp" -->
      

      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
          <div class="row">
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Edit Employee</h4>
                    <p class="card-description">
                        Edit Employee
                    </p>
                    <%
                    Set cmdPrep = Server.CreateObject("ADODB.Command")
                    cmdPrep.ActiveConnection = connDB
                    cmdPrep.CommandType = 1
                    cmdPrep.Prepared = True
                    cmdPrep.CommandText = "select users.* from users where ID_user = "&ID_employeeEdit

                    Set Result = cmdPrep.execute
                    do while not Result.EOF
                    %>
                    <form class="forms-sample">
                        <div class="form-group">
                        <label for="exampleInputName1">First Name</label>
                        <input name="firstName" type="text" value="<%=Result("firstName")%>" class="form-control" id="exampleInputName1" required placeholder="First Name">
                        </div>
                        <div class="form-group">
                        <label for="exampleInputName1">Last Name</label>
                        <input name="lastName" type="text" value="<%=Result("lastName")%>" class="form-control" id="exampleInputName1" required placeholder="Last Name">
                        </div>
                        <div class="form-group">
                        <label for="exampleInputName1">Identity Card</label>
                        <input name="cmnd" type="text" value="<%=Result("cmnd")%>" class="form-control" id="exampleInputName1" required placeholder="Identity Card">
                        </div>
                        <div class="form-group">
                        <label for="exampleInputCity1">Phone Number</label>
                        <input name="phone_number" type="text" value="<%=Result("phone_number")%>" class="form-control" id="exampleInputCity1" required placeholder="Phone Number">
                        </div>
                        <div class="form-group">
                        <label for="exampleInputCity1">Birthday</label>
                        <input name="birthDay" type="date" value="<%=Result("birthday")%>" class="form-control" id="birthdayID" required placeholder="Birthday">
                        <input name="phone_number" type="text" value="<%=Result("birthday")%>" class="form-control" id="exampleInputCity1" required placeholder="Phone Number">
                        </div>
                        <div class="form-group">
                        <label for="exampleInputCity1">Join on</label>
                        <input name="join" type="date" value="<%=Result("joindate")%>" class="form-control" id="exampleInputCity1" required placeholder="Official Working Day">
                        <input name="phone_number" type="text" value="<%=Result("joindate")%>" class="form-control" id="exampleInputCity1" required placeholder="Phone Number">
                        </div>
                        <div class="form-group">
                        <label for="exampleSelectGender">Gender</label>
                            <select name="gender" class="form-control" id="selectGender" required>
                                <% if (Result("gender")) then %>
                                    <option value="1">Male</option>
                                    <option value="2">Female</option>
                                <% else %>
                                    <option value="2">Female</option>
                                    <option value="1">Male</option>
                                <% end if%>
                            </select>
                        </div>
                        <div class="form-group">
                        <label>File upload</label>
                        <input type="file" name="avt" class="file-upload-default">
                        <div class="input-group col-xs-12">
                            <input type="file" class="form-control file-upload-info" required placeholder="Upload Image" onchange="handleFileUpload(this)">
                        </div>
                        </div>
                        <ol id="filelist" style="display: flex;">

                        </ol>	
                        <input class="nameAvt" type="hidden" value="<%=Result("avatar")%>">
                        
                        <button type="submit" class="submit btn btn-primary me-2">Submit</button>
                        <button class="cancel btn btn-light">Cancel</button>
                    </form>
                    <%
                    Result.MoveNext
                    loop
                    %>
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
    
    </div>
    <!-- #include file="../../js/mainJs.asp" -->
    <script>
        var submitBtn = document.querySelector('.submit');
        //   var filelist = document.getElementById("filelist");

        var email = ''
        var password = ''
        var successPassword = true;
        var successForm = true;

        const alertEmptyForm = (text) => {
            if (text == '') {
            alert('Please enter enough information!');
            successForm = false;
            }
        }
        const validatePassword = (password) => {
        // Kiểm tra độ dài mật khẩu (từ 8 đến 20 ký tự)
            const passErrorBlock = document.querySelector('.pass-error');
            passErrorBlock.innerHTML = '';
            var passLength = false;
            var passChar = false;
            var passNum = false;
            var passSpecialChar = false;

            if (password.length >= 6) {
            passLength = true;
            }

            // Kiểm tra mật khẩu có chứa ký tự chữ (a-z, A-Z)
            if (/[a-zA-Z]/.test(password)) {
            passChar = true;
            }

            // Kiểm tra mật khẩu có chứa ký tự số (0-9)
            if (/\d/.test(password)) {
            passNum = true;
            }

            // Kiểm tra mật khẩu có chứa ký tự đặc biệt
            if (/[!@#$%^&*]/.test(password)) {
            passSpecialChar = true;
            }
            if (passLength == true && passChar == true && passNum == true && passSpecialChar == true) {
            successPassword = true;
            } else {
            successPassword = false;
            }
            
            if (passLength == true) {
            passErrorBlock.innerHTML += `<span class="pass-suc"><i class="fa-solid fa-check"></i> Password with at least 6 characters</span>`;
            } else {
            passErrorBlock.innerHTML += `<span class="pass-err"><i class="fa-solid fa-xmark"></i> Password with at least 6 characters</span>`;
            }

            if (passChar == true) {
            passErrorBlock.innerHTML += `<span class="pass-suc"><i class="fa-solid fa-check"></i> Password with alphanumeric characters</span>`;
            } else {
            passErrorBlock.innerHTML += `<span class="pass-err"><i class="fa-solid fa-xmark"></i> Password with alphanumeric characters</span>`;
            }

            if (passNum == true) {
            passErrorBlock.innerHTML += `<span class="pass-suc"><i class="fa-solid fa-check"></i> Password with numeric characters</span>`;
            } else {
            passErrorBlock.innerHTML += `<span class="pass-err"><i class="fa-solid fa-xmark"></i> Password with numeric characters</span>`;
            }

            if (passSpecialChar == true) {
            passErrorBlock.innerHTML += `<span class="pass-suc"><i class="fa-solid fa-check"></i> Password with special characters</span>`;
            } else {
            passErrorBlock.innerHTML += `<span class="pass-err"><i class="fa-solid fa-xmark"></i> Password with special characters</span>`;
            }
        }

        var firstName = '';
        var lastName = '';
        var cmnd = '';
        var phone_number = '';
        var birthDay = '';
        var join = '';
        var gender = '';
        // var avt = '';
        var nameAvt = document.querySelector('.nameAvt');
        var filelist = document.getElementById("filelist");
        filelist.innerHTML = `
        <img class="imgUp" src="/fashionShop/resources/imgUser/${nameAvt.value}" >
        `
        var avt = nameAvt.value;

        const addUser = () => {
            firstName = document.querySelector('input[name="firstName"]').value;
            lastName = document.querySelector('input[name="lastName"]').value;
            cmnd = document.querySelector('input[name="cmnd"]').value;
            phone_number = document.querySelector('input[name="phone_number"]').value;
            birthDay = document.querySelector('input[name="birthDay"]').value;
            join = document.querySelector('input[name="join"]').value;
            gender = document.getElementById('selectGender').value;

            alertEmptyForm(firstName)
            alertEmptyForm(lastName)
            alertEmptyForm(cmnd)
            alertEmptyForm(phone_number)
            alertEmptyForm(birthDay)
            alertEmptyForm(join)
            alertEmptyForm(gender)
            
            if (successPassword == true && successForm == true) {
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.open("GET", "/fashionShop/controllers/admin/addEmployee.asp?firstName=" + firstName + "&lastName=" + lastName + "&cmnd=" + cmnd + "&phone_number=" + phone_number + "&birthDay=" + birthDay + "&join=" + join + "&gender=" + gender + "&avt=" + avt, true);
            // console.log(ID_product)
            xmlhttp.send();
            }
        }
        const handleFileUpload = (input) => {
            const uploadedFile = input.files[0];

            if (uploadedFile) {
                // listImage.push(uploadedFile.name)
                console.log('Tên tệp tin:', uploadedFile.name);
                
                var li = document.createElement("li");
                
                filelist.innerHTML = `
                <img class="imgUp" src="/fashionShop/resources/imgUser/${uploadedFile.name}" >
                `
                avt = uploadedFile.name;
            } else {
                console.log('Chưa có tệp tin nào được tải lên.');
            }
        }
        
        submitBtn.addEventListener('click', (e) => {
            e.preventDefault();
            // addAccount();
            addUser();
        })
    </script>
</body>

</html>