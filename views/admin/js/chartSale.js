var listData = [];

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

function getWeekdays(date) {
    var dayOfWeek = date.getDay();
    var weekdays = [];

    for (var i = 0; i < 7; i++) {
        var currentDate = new Date(date);
        currentDate.setDate(date.getDate() + i - dayOfWeek);
        var formattedDateISO = currentDate.toISOString().split('T')[0];
        weekdays.push({
            day: currentDate.toLocaleDateString(undefined, { weekday: 'long' }),
            ngay: formattedDateISO
        });
    }

    return weekdays;
}

// Sử dụng ví dụ với ngày đầu vào là '2023-05-30'
var inputDate = new Date('2023-05-30');
var selectDay = document.getElementById('select_day');
selectDay.valueAsDate = new Date();

selectDay.onchange = () => {
    var weekdays = getWeekdays(inputDate);
    setTimeout(() => {
        for (var i = 0; i < weekdays.length; i++) {
            // console.log(weekdays[i].ngay);
            getRevenue(weekdays[i].ngay);
            // listData
        }
        setTimeout(() => {
            renderChart();
        }, 500);
    }, 1000);
    

}
// console.log(listData)

var renderChart = () => {

    var areaData = {
        labels: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
        datasets: [{
            label: '# of Votes',
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
