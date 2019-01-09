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

    $(".task-detail").click(function () {
        var url = $(this).attr("data-url");
        // console.log(url);
        $.ajax({
            dataType: "script",
            type: "GET",
            url: url
        });
    })
});