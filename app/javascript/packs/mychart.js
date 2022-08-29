  // $(document).ready(function() => {
    const ctx = document.getElementById('chart').getContext('2d');
    const day0 = document.getElementById('day0').textContent;
    const day1 = document.getElementById('day1').textContent;
    const day2 = document.getElementById('day2').textContent;
    const day3 = document.getElementById('day3').textContent;
    const day4 = document.getElementById('day4').textContent;
    const day5 = document.getElementById('day5').textContent;
    const day6 = document.getElementById('day6').textContent;

    const chart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: ['6日前', '5日前', '4日前', '3日前', '2日前', '1日前', '今日'],
        datasets: [{
            label: '投稿した本の数',
            data: [day6, day5, day4, day3, day2, day1, day0],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)',
                'rgba(255, 99, 132, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)',
                'rgba(255, 99, 132, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

// });
