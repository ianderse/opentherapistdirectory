function render(element) {
  var location_address = element.location_street1 + " " + element.location_street2 + " " + element.location_city + " " + element.location_state + " " + element.location_zip
  location_address = location_address.replace(null, "");
  $('.list').append("<li><h3>" + element.name1 + "</h3><a href='#'><i class='fa fa-plus-circle add-map-pin' style='float:right' data-street='" + location_address + "'></i></a><p>" + location_address + "<br/><a href='/facilities/" + element.id + "'>More Information</a>"+"</li>");
};

$('#filter-none').on('click', function() {
  $('.list').empty();
  _.each(firstFacilities, render);
})

$('#filter-state').on('change', function() {
  var state = $(this).val();
  currentFacilities = _.filter(facilities, function(facility) {
    return facility.location_state === state;
  });
  $('.list').empty();
  _.each(currentFacilities, render);
});

$( ".search" ).keyup(function() {
  var params = $(this).val().toLowerCase();
  if (!params) {
    $('.list').empty();
    _.each(currentFacilities, render);
  } else {
    var searchedFacilities = _.filter(currentFacilities, function(facility) {
      var searchable = (facility.location_state + facility.location_city + facility.services_text1 + facility.services_text2 + facility.services_text3 + facility.services_text4 + facility.services_text5 + facility.services_text6 + facility.services_text7).toLowerCase();
      return ~searchable.indexOf(params);
    });
    $('.list').empty();
    _.each(searchedFacilities, render);
  }
});
