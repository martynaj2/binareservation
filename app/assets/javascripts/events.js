$('#datetimepicker1').datetimepicker({
  stepping: 15,
  minDate: Date(),
  maxDate: new Date(Date.now() + (365 * 24 * 60 * 60 * 1000)),
  sideBySide: true,
  icons: {
    up: 'fa fa-arrow-up',
    down: 'fa fa-arrow-down',
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    close: 'fa fa-times'
  },
  buttons: {showClose: true }
});

$('#datetimepicker2').datetimepicker({
  format: 'MMMM D, YYYY h:mm A',
  stepping: 15,
  useCurrent: false,
  sideBySide: true,
  icons: {
    up: 'fa fa-arrow-up',
    down: 'fa fa-arrow-down',
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    close: 'fa fa-times'
  },
  buttons: {showClose: true }
});
$("#datetimepicker1").on("change.datetimepicker", function (e) {
  $('#datetimepicker2').datetimepicker('minDate', e.date);
  console.log(e.date);
});
$("#datetimepicker2").on("change.datetimepicker", function (e) {
  $('#datetimepicker1').datetimepicker('maxDate', e.date);
});
