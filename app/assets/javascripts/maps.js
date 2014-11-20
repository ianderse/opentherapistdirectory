$('.add-map-pin').on('click', function() {
  var address = $(this).data('street');
  console.log(address);
  addMarker(address);
});
