var listData = [];
var QuantityTotalWeek = 0;

var getRevenue = function (data) {
    $.ajax({
        url: '/fashionShop/controllers/admin/getRevenue.asp',
        data: { day: data },
        dataType: 'json',
        success: function (response) {
            console.log(response[0]);
            if (response[0].id == 1) {
                var quantityInt = parseInt(response[0].quantity);
                
                console.log(quantityInt);
                QuantityTotalWeek = QuantityTotalWeek + quantityInt;
                listData.push(quantityInt);
            } else {
                listData.push(0);
            }
        },
        error: function (response) {
            alert('Lỗi AJAX');
        }
    });
}

function getWeekDays() {
    var currentDate = new Date();
    var days = [];

    for (var i = 0; i < 7; i++) {
        var day = new Date(currentDate);
        day.setDate(currentDate.getDate() - currentDate.getDay() + i + 1);
        days.push(day);
    }

    return days;
}

var weekDays = getWeekDays();
var weekDaysFormat = []

weekDays.forEach(function (weekDay, index) {
    // getRevenue(weekDay);
    weekDaysFormat[index] = weekDay.toLocaleDateString('en-US', { 
        year: 'numeric', 
        month: 'numeric',
        day: 'numeric' 
    })
    getRevenue(weekDaysFormat[index])
});
// weekDaysFormat.forEach(day => {
//     getRevenue(day)
// });
setTimeout(() => {
    console.log(weekDaysFormat)
    console.log(listData)
    const ctx = document.getElementById('myChart');

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
            datasets: [{
                label: 'Orders',
                data: listData,
                borderWidth: 1
            }]
        },
        fill: false,
        backgroundColor: 'rgb(75, 192, 192)',
        borderColor: 'rgb(75, 192, 192)',
        tension: 0.1,
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}, 800);

