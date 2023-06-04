var listData = [];
var listDataTotal = [];
var listDataDay = [];

var getRevenue = function (data) {
    $.ajax({
        url: '/fashionShop/controllers/admin/getRevenue.asp',
        data: { day: data },
        dataType: 'json',
        success: function (response) {
            // console.log(response);
            // In ra các thứ trong tuần
            if (response[0]) {

                // console.log(data)
                // console.log(Date.parse(response[0].oder_day))
                // console.log(Date.parse(data))
                if (data == response[0].oder_day) {
                    var quantityInt = parseInt(response[0].quantity)
                    // console.log(quantityInt)

                    listData.push(quantityInt)
                } else {
                    listData.push(0)
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
                    var totalInt = parseInt(response[0].total_price)
                    // console.log(totalInt)

                    listDataTotal.push(totalInt)
                } else {
                    listDataTotal.push(0)
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
    // var dayOfWeek = date.getDay();
    var weekdays = [];
    // console.log()

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

// Sử dụng ví dụ với ngày đầu vào là '2023-05-30'
// var inputDate = new Date('2023-05-30');
var selectDay = document.getElementById('select_day');
selectDay.valueAsDate = new Date();

var render = function() {
    var inputDate = new Date(selectDay.value);
    var weekdays = getWeekdays(inputDate);
    
    for (var i = 0; i < weekdays.length; i++) {
        // console.log(weekdays[i].ngay);
        listDataDay.push(weekdays[i].ngay);
    }
    setTimeout(() => {
        for (var i = 0; i < weekdays.length; i++) {
            getRevenue(weekdays[i].ngay);
            getRevenueTotal(weekdays[i].ngay);
        }
        setTimeout(() => {
            renderChart();
            renderTotalChart();
            listData = [];
            listDataTotal = [];
            listDataDay = [];
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
    // var areaDataTotal = {
    //     // labels: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
    //     labels: listDataDay,
    //     datasets: [{
    //         label: 'Revenue',
    //         data: listDataTotal, // data cho biểu đồ
    //         backgroundColor: [
    //             'rgba(255, 99, 132, 0.2)',
    //             'rgba(54, 162, 235, 0.2)',
    //             'rgba(255, 206, 86, 0.2)',
    //             'rgba(75, 192, 192, 0.2)',
    //             'rgba(153, 102, 255, 0.2)',
    //             'rgba(255, 159, 64, 0.2)',
    //             'rgba(75, 192, 192, 0.2)'
    //         ],
    //         borderColor: [
    //             'rgba(255,99,132,1)',
    //             'rgba(54, 162, 235, 1)',
    //             'rgba(255, 206, 86, 1)',
    //             'rgba(75, 192, 192, 1)',
    //             'rgba(153, 102, 255, 1)',
    //             'rgba(255, 159, 64, 1)',
    //             'rgba(75, 192, 192, 1)'
    //         ],
    //         borderWidth: 1,
    //         fill: true, // 3: no fill
    //     }]
    // };

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
    // if ($("#areaChartTotal").length) {
    //     var areaChartCanvas = $("#areaChartTotal").get(0).getContext("2d");
    //     var areaChartTotal = new Chart(areaChartCanvas, {
    //         type: 'line',
    //         data: areaDataTotal,
    //         options: areaOptions
    //     });
    // }
}
var renderTotalChart = () => {

    var areaDataTotal = {
        // labels: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
        labels: listDataDay,
        datasets: [{
            label: 'Revenue',
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
// var renderTotalChart = () => {

//     var areaDataTotal = {
//         // labels: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
//         labels: listDataDay,
//         datasets: [{
//             label: 'Revenue',
//             data: listDataTotal, // data cho biểu đồ
//             backgroundColor: [
//                 'rgba(255, 99, 132, 0.2)',
//                 'rgba(54, 162, 235, 0.2)',
//                 'rgba(255, 206, 86, 0.2)',
//                 'rgba(75, 192, 192, 0.2)',
//                 'rgba(153, 102, 255, 0.2)',
//                 'rgba(255, 159, 64, 0.2)',
//                 'rgba(75, 192, 192, 0.2)'
//             ],
//             borderColor: [
//                 'rgba(255,99,132,1)',
//                 'rgba(54, 162, 235, 1)',
//                 'rgba(255, 206, 86, 1)',
//                 'rgba(75, 192, 192, 1)',
//                 'rgba(153, 102, 255, 1)',
//                 'rgba(255, 159, 64, 1)',
//                 'rgba(75, 192, 192, 1)'
//             ],
//             borderWidth: 1,
//             fill: true, // 3: no fill
//         }]
//     };

//     var areaOptions = {
//         plugins: {
//             filler: {
//                 propagate: true
//             }
//         }
//     }
//     if ($("#areaChartTotal").length) {
//         var areaChartCanvas = $("#areaChartTotal").get(0).getContext("2d");
//         var areaChartTotal = new Chart(areaChartCanvas, {
//             type: 'line',
//             data: areaDataTotal,
//             options: areaOptions
//         });
//     }
// }
