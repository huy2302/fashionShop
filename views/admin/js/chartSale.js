var listData = [];
var listDataTotal = [];
var listDataDay = [];
var totalWeek = 0;
var QuantityTotalWeek = 0;

var totalMonth = 0;
var QuantityTotalMonth = 0;

var getRevenue = function (data) {
    $.ajax({
        url: '/fashionShop/controllers/admin/getRevenue.asp',
        data: { day: data },
        dataType: 'json',
        success: function (response) {
            // console.log(response);
            // In ra các thứ trong tuần
            if (response[0]) {

                if (data == response[0].oder_day) {
                    var quantityInt = parseInt(response[0].quantity);

                    console.log(quantityInt);
                    QuantityTotalWeek = QuantityTotalWeek + quantityInt;
                    listData.push(quantityInt);
                } else {
                    listData.push(0);
                }
            }
        },
        error: function (response) {
            alert('Lỗi AJAX');
        }
    });
}
var getRevenueTotal = function (data) {
    $.ajax({
        url: '/fashionShop/controllers/admin/getRevenueTotal.asp',
        data: { day: data },
        dataType: 'json',
        success: function (response) {
            // console.log(response);
            // In ra các thứ trong tuần
            if (response[0]) {
                if (data == response[0].oder_day) {
                    var totalInt = parseInt(response[0].total_price);
                    // console.log(totalInt)
                    totalWeek = totalWeek + totalInt;
                    listDataTotal.push(totalInt);
                } else {
                    listDataTotal.push(0);
                }
            }

            response.forEach(function (obj) {
                if (obj.id == "-1") {
                    return;
                }
                console.log()
            });
        },
        error: function (response) {
            alert('Lỗi AJAX');
        }
    });
}

function getWeekdays(date) {
    var weekdays = [];

    for (var i = 0; i < 7; i++) {
        var currentDate = new Date(date);
        currentDate.setDate(date.getDate() + i);
        var formattedDateISO = currentDate.toISOString().split('T')[0];
        weekdays.push({
            day: currentDate.toLocaleDateString(undefined, { weekday: 'long' }),
            ngay: formattedDateISO
        });
    }
    return weekdays;
}
function getMonthdays(date) {
    var monthdays = [];

    for (var i = 0; i < 30; i++) {
        var currentDate = new Date(date);
        currentDate.setDate(date.getDate() - i);
        var formattedDateISO = currentDate.toISOString().split('T')[0];
        monthdays.push({
            day: currentDate.toLocaleDateString(undefined, { monthday: 'long' }),
            ngay: formattedDateISO
        });
    }
    return monthdays;
}
var renderDetails = function() {
    var weekSales = document.querySelector('.weekSales');
    var weekRevenue = document.querySelector('.weekRevenue');

    if (QuantityTotalWeek > 0) {
        weekSales.innerHTML = QuantityTotalWeek;
    } else weekSales.innerHTML = '0';

    if (totalWeek > 0) {
        weekRevenue.innerHTML = '$'+totalWeek+'.00';
    } else weekRevenue.innerHTML = '$0.00';

}
// Sử dụng ví dụ với ngày đầu vào là '2023-05-30'
// var inputDate = new Date('2023-05-30');
var selectDay = document.getElementById('select_day');
// lấy ra 7 ngày trước ngày hiện tại
var currentDate = new Date();
selectDay.valueAsDate = new Date(currentDate.getTime() - 7 * 24 * 60 * 60 * 1000);


var render = function() {
    var inputDate = new Date(selectDay.value);
    var weekdays = getWeekdays(inputDate);
    var monthdays = getMonthdays(inputDate);
    
    for (var i = 0; i < weekdays.length; i++) {
        listDataDay.push(weekdays[i].ngay);
    }
    setTimeout(() => {
        for (var i = 0; i < weekdays.length; i++) {
            getRevenue(weekdays[i].ngay);
            getRevenueTotal(weekdays[i].ngay);
        }

        setTimeout(() => {
            renderDetails();
            renderChart();
            renderTotalChart();
            listData = [];
            listDataTotal = [];
            listDataDay = [];
            totalWeek = 0;
            QuantityTotalWeek = 0;
        }, 100);
    }, 100);
}
render()
selectDay.onchange = render
var btnPrev = document.getElementById("btn-prev");
var btnNext = document.getElementById("btn-next");
btnPrev.onclick = () => {
    var input = document.getElementById("select_day");
    var currentDate = new Date(input.value);
    currentDate.setDate(currentDate.getDate() - 1);
    var formattedDate = currentDate.toISOString().split("T")[0];
    input.value = formattedDate;
    render();
}
btnNext.onclick = () => {
    var input = document.getElementById("select_day");
    var currentDate = new Date(input.value);
    currentDate.setDate(currentDate.getDate() + 1);
    var formattedDate = currentDate.toISOString().split("T")[0];
    input.value = formattedDate;
    render();
}

var renderChart = () => {

    var areaData = {
        // labels: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
        labels: listDataDay,
        datasets: [{
            label: 'Number of orders',
            data: listData, // data cho biểu đồ
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)',
                'rgba(75, 192, 192, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)',
                'rgba(75, 192, 192, 1)'
            ],
            borderWidth: 1,
            fill: true, // 3: no fill
        }]
    };

    var areaOptions = {
        plugins: {
            filler: {
                propagate: true
            }
        }
    }
    if ($("#areaChart").length) {
        var areaChartCanvas = $("#areaChart").get(0).getContext("2d");
        var areaChart = new Chart(areaChartCanvas, {
            type: 'line',
            data: areaData,
            options: areaOptions
        });
    }
}
var renderTotalChart = () => {

    var areaDataTotal = {
        // labels: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
        labels: listDataDay,
        datasets: [{
            label: 'Revenue (Dollar - $)',
            data: listDataTotal, // data cho biểu đồ
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)',
                'rgba(75, 192, 192, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)',
                'rgba(75, 192, 192, 1)'
            ],
            borderWidth: 1,
            fill: true, // 3: no fill
        }]
    };

    var areaOptions = {
        plugins: {
            filler: {
                propagate: true
            }
        }
    }
    if ($("#areaChartTotal").length) {
        var areaChartCanvas = $("#areaChartTotal").get(0).getContext("2d");
        var areaChartTotal = new Chart(areaChartCanvas, {
            type: 'line',
            data: areaDataTotal,
            options: areaOptions
        });
    }
}
const xValues = [100,200,300,400,500,600,700,800,900,1000];

const renderNewChart = () => {
    new Chart("myChart", {
        type: "line",
        data: {
            labels: xValues,
            datasets: [{ 
                data: [860,1140,1060,1060,1070,1110,1330,2210,7830,2478],
                borderColor: "red",
                fill: false
            }, { 
                data: [1600,1700,1700,1900,2000,2700,4000,5000,6000,7000],
                borderColor: "green",
                fill: false
            }, { 
                data: [300,700,2000,5000,6000,4000,2000,1000,200,100],
                borderColor: "blue",
                fill: false
            }]
        },
        options: {
            legend: {display: false}
        }
    });
}