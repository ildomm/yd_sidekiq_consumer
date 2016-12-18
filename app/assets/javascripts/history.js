// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function refresh_sequence(){
    $(document).ready(
        function() {
            setInterval(function() {
                $('.dynamic_index').load('/history/sequence_refresh');
            }, 30000 );
        });
}

function refresh_unique(){
    $(document).ready(
        function() {
            setInterval(function() {
                $('.dynamic_hour').load('/history/unique_refresh');
            }, 30000 );
        });
}