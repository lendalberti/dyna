$( document ).ready(function() {

   $('#locations_table').DataTable({
      "order": [[ 3, "desc" ]]
   });

   $('#lookup_address').on('click', function() {
      var lookupURL = 'location/lookup';
      var postData = { address: $('#address').val() };

      $.ajax({
          url: lookupURL,
          type: 'POST',
          data: postData,
          success: function (res) {
            console.log("Results: " + res);
            location.reload(); 
          },
          error: function (jqXHR, textStatus, errorThrown)  {
            console.log( "Couldn't locate this address... " + JSON.stringify(jqXHR) );
          }
      });
   });



});
