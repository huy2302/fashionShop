<%
' Độ dài của dãy ký tự ngẫu nhiên
Dim doDai
doDai = 10 ' Đặt độ dài là 10, bạn có thể thay đổi giá trị tùy ý

' Hàm tạo dãy ký tự ngẫu nhiên
Function TaoDayKyTuNgauNhien(doDai)
    Dim kyTuNgauNhien, i
    Dim chuoiKyTuNgauNhien
    
    Randomize ' Khởi tạo bộ sinh số ngẫu nhiên
    
    For i = 1 To doDai
        kyTuNgauNhien = Int((90 - 65 + 1) * Rnd + 65) ' Tạo số ngẫu nhiên từ 65 đến 90 (mã ASCII của các chữ cái in hoa từ A đến Z)
        chuoiKyTuNgauNhien = chuoiKyTuNgauNhien & Chr(kyTuNgauNhien) ' Chuyển đổi mã ASCII thành ký tự và nối vào chuỗi
    Next
    
    TaoDayKyTuNgauNhien = chuoiKyTuNgauNhien ' Trả về dãy ký tự ngẫu nhiên
End Function

' Sử dụng hàm để tạo dãy ký tự ngẫu nhiên
Dim dayKyTuNgauNhien
dayKyTuNgauNhien = TaoDayKyTuNgauNhien(doDai)

' In ra dãy ký tự ngẫu nhiên
Response.Write "Day Ky Tu Ngau Nhien: " & dayKyTuNgauNhien
%>