$(document).on('turbolinks:load', function() {
    $('#radio-solo').click(function(){
        $('#radio-04').attr('disabled', true);
        $('#radio-03').click();
    });
    $('#radio-startup').click(function(){
        $('#radio-04').attr('disabled', false);
    });
    $('#radio-enterprise').click(function(){
        $('#radio-04').attr('disabled', false);
    });
});