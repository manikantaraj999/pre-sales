// On page load, attach jquery ui datepicker to all fields with class jqDate
$(document).ready(function() {
    // If you try to do this on anything inside the body, any controller
    // action causes apex to recreate it and the event handler to get lost
    $('body').on('focus', '.jqDate', function(e) {
        $(this).datepicker({ dateFormat: 'mm/dd/yy' });
    });
});