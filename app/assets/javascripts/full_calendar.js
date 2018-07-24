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
      events: '/home.json',

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
          $(this).css('background-color', 'purple');
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

<<<<<<< HEAD
      selectOverlap: function(event) {
        return ! event.block;
      },
=======
        },
        selectOverlap: function(event) {
          return ! event.block;
        },
>>>>>>> 0ab651421cf0e971b5c182a93a1476969eda8520

    });

  })


};

$(document).on('turbolinks:load', initialize_calendar);
