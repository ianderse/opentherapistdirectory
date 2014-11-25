$('.add-map-pin').on('click', function() {
  var address = $(this).data('street');
  addMarker(address);
});
