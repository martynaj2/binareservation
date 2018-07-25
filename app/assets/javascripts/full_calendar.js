var initialize_calendar;
initialize_calendar = function() {
  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      minTime: "07:00:00",
      maxTime: "18:00:00",
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      weekends: false,

      dayClick: function(date) {

        var start_date = date;
        if(!start_date.hasTime()) {
          start_date.time('12:00:00');
        }
        window.location.href='/reservations/new?start_date=' + start_date.format() + '&end_date=' + start_date.add('hours', 1).format();
        $(this).css('background-color', 'purple');
      },

      select: function( start, end, jsEvent, view) {

        $(".calendar").fullCalendar('addEventSource', [{
            start: start,
            end: end,
            rendering: 'background',
            block: true,
        }, ]);

        window.location.href='/reservations/new?start_date=' + start.format() + '&end_date=' + end.format();
        $(".calendar").fullCalendar("unselect");

        },
        selectOverlap: function(event) {
          return ! event.block;
        },


    });
  })
};
$(document).on('turbolinks:load', initialize_calendar);
