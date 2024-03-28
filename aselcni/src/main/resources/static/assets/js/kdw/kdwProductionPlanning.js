$(document).ready(function() {
  var calendarEl = $('#calendar')[0];
  var calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth'
  });
  calendar.render();
});