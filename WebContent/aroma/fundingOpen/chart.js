let draw = Chart.controllers.line.prototype.draw;

Chart.controllers.line = Chart.controllers.line.extend({
  draw: function () {
    draw.apply(this, arguments);
    let ctx = this.chart.chart.ctx;
    let _stroke = ctx.stroke;
    ctx.stroke = function () {
      ctx.save();
      ctx.shadowColor = "#2b3840";
      ctx.shadowBlur = 10;
      ctx.shadowOffsetX = 0;
      ctx.shadowOffsetY = 3;
      _stroke.apply(this, arguments);
      ctx.restore();
    };
  },
});

var ctx = document.getElementById("lineChart").getContext("2d");
var labels = [
  "01 Jul",
  "02 Jul",
  "03 Jul",
  "04 Jul",
  "05 Jul",
  "06 Jul",
  "07 Jul",
];

Chart.defaults.global.legend.labels.usePointStyle = true;

var data = {
  fill: false,
  labels: labels,
  datasets: [
    {
      fill: false,
      label: "Negative",
      data: [25, 50, 20, 90, 80, 75, 99, 59, 40],
      borderColor: ["rgba(255, 99, 132, 1)"],
      borderWidth: 5,
      pointRadius: 0,
    },
    {
      fill: false,
      label: "Positive",
      data: [20, 30, 50, 15, 70, 34, 39, 32, 40],
      borderColor: ["rgba(80, 204, 168, 1)"],
      borderWidth: 5,
      pointRadius: 0,
    },
  ],
};
var options = {
  responsive: true,
  maintainAspectRatio: false,
  layout: {
    padding: {
      left: 50,
      right: 50,
      top: 50,
      bottom: 50,
    },
  },
  title: {
    display: true,
    text: "Rezultatet sipas pikëve",
    fontFamily: "Raleway",
    fontColor: "#434a52",
  },
  scales: {
    yAxes: [
      {
        ticks: {
          beginAtZero: true,
        },
      },
    ],
    xAxes: [
      {
        gridLines: {
          // Remove vertical lines
          display: false,
          drawBorder: false,
        },
      },
    ],
  },
};
var myChart = new Chart(ctx, {
  type: "line",
  backgroundColor: "white",

  data: data,
  options: options,
});