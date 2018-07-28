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
      editable: false,
      eventLimit: true,
      weekends: false,
      events: '/home.json',
      defaultView: (localStorage.getItem("fcDefaultView") !== null ? localStorage.getItem("fcDefaultView") : "agendaWeek"),

      viewRender: function (view, element) {
        localStorage.setItem("fcDefaultView", view.name);
      },

      dayClick: function(date) {
        var startDate = moment(date);
        var today = moment();
        if(!startDate.hasTime()) startDate.time('23:59:59');

        if(startDate < today)
        {
          $('.calendar').fullCalendar('unselect');
        }
        else
        {
          window.location.href='/reservations/new?start_date=' + date.format() + '&end_date=' + date.format();
        }
      },

      select: function( start, end, jsEvent, view) {
        var selectionStart = moment(start);
        var today = moment();
        if(!selectionStart.hasTime()) selectionStart.time('23:59:59');

        if (selectionStart < today) {
          $('.calendar').fullCalendar('unselect');
        }
        else {
          $(".calendar").fullCalendar('addEventSource', [{
              start: start,
              end: end,
              rendering: 'background',
              block: true,
          }, ]);
          window.location.href='/reservations/new?start_date=' + start.format() + '&end_date=' + end.format();
        }
        $(".calendar").fullCalendar("unselect");
      },

      selectOverlap: function(event) {
        return ! event.block;
      },
    });
  })
};

$(document).on('turbolinks:load', initialize_calendar);
