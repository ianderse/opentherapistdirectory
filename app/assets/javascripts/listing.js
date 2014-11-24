var state = $('#filter-state').val();

function render(element) {
  var location_address = element.location_street1 + " " + element.location_street2 + " " + element.location_city + " " + element.location_state + " " + element.location_zip
  location_address = location_address.replace(null, "");
  $('.list').append("<li><h3>" + element.name1 + "</h3><a href='#'><i class='fa fa-plus-circle add-map-pin' style='float:right' data-street='" + location_address + "'></i></a><p>" + location_address + "<br/><a href='/facilities/" + element.id + "'>More Information</a>" + "<a class='add-facility' href='/facility/save/" + element.id + "' remote: true> Save Facility</a>" + "</li>");
};

function filterState() {
  currentFacilities = _.filter(facilities, function(facility) {
    return facility.location_state === state;
  });
  $('.list').empty();
  _.each(currentFacilities, render);
}

$('#filter-none').on('click', function() {
  $('.list').empty();
  _.each(firstFacilities, render);
})

$('#filter-state').on('change', function() {
  state = $('#filter-state').val();
  filterState();
});

$( ".search" ).keyup(function() {
  var params = $(this).val().toLowerCase();
  if (!params) {
    $('.list').empty();
    _.each(currentFacilities, render);
  } else {
    var searchedFacilities = _.filter(currentFacilities, function(facility) {
      var services = (facility.services_text1 + facility.services_text2 + facility.services_text3 + facility.services_text4 + facility.services_text5 + facility.services_text6 + facility.services_text7)
      var searchable = (facility.name1 + facility.location_state + facility.location_city + services).toLowerCase();
      return ~searchable.indexOf(params);
    });
    $('.list').empty();
    _.each(searchedFacilities, render);
  }
});

$('.sort').on('click', function() {
  var sort = $(this).data('sort');

  var sortedList = _.sortBy(currentFacilities, function(facility) {
    if(sort === 'name') {
      return facility.name1.toLowerCase();
    } else if(sort === 'city') {
      return facility.location_city.toLowerCase();
    }
  })

  $('.list').empty();
  _.each(sortedList, render);
});

$(".add-facility").on("click",function(e) {
    e.preventDefault();
    $.post(this.href,function(data) {});
  });

$('.check').change(function(){
  var check = $(this).data('check');
  if ($(this).is(":checked")){
    currentFacilities = _.filter(currentFacilities, function(facility) {
      var services = (facility.services_text1 + facility.services_text2 + facility.services_text3 + facility.services_text4 + facility.services_text5 + facility.services_text6 + facility.services_text7).toLowerCase();
      console.log(check);
      return ~services.indexOf(check);
    });
    $('.list').empty();
    _.each(currentFacilities, render);
  } else {
    $('.list').empty();
    filterState();
  }
});
