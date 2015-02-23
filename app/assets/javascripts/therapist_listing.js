 function setInitialState(value) {
  $('#filter-state').val(value);
}

function render(element) {
  var location_address = element['location']['street_1'] + " " + element['location']['street_2'] + " " + element['location']['city'] + " " + element['location']['state'] + " " + element['location']['zipcode']
  location_address = location_address.replace(null, "");
  var listingElement = $("<div><li><img src=" + element['picture_url'] + " alt='therapist-picture' class=therapist-thumb><h3>" + element['full_name'] + " " + element['certifications'] + "<p class='phone'>" + element['phone'] + "</p></h3><p>" + location_address + "<p class='description'>\"" + element['trunc_desc'] + "\"</p><br/><div class='bottom-items'><a class='more-information' href='/therapists/" + element['id'] + "'>More Information</a> | " + "<a class='add-therapist' href='/therapist/save/" + element['id'] + "' remote: true> Save Therapist</a></div></li></div>");
  $('.list').append(listingElement);
  addTherapist();
};

function filterState() {
  currentTherapists = _.filter(therapists, function(therapist) {
    return therapist.location.state === state;
  });
  $('.list').empty();
  _.each(currentTherapists, render);
}

$('#filter-none').on('click', function() {
  $('.list').empty();
  _.each(firstTherapists, render);
})

$('#filter-state').on('change', function() {
  state = $('#filter-state').val();
  $('.check').prop('checked', false);
  filterState();
});

$( ".search" ).keyup(function() {
  var params = $(this).val().toLowerCase();
  if (!params) {
    $('.list').empty();
    _.each(currentTherapists, render);
  } else {
    var searchedTherapists = _.filter(currentTherapists, function(therapist) {
      var searchable = (therapist.description + therapist.first_name + therapist.last_name + therapist.location.city + therapist.location.zipcode).toLowerCase();
      return ~searchable.indexOf(params);
    });
    $('.list').empty();
    _.each(searchedTherapists, render);
  }
});

$('.sort').on('click', function() {
  var sort = $(this).data('sort');

  var sortedList = _.sortBy(currentTherapists, function(therapist) {
    if(sort === 'name') {
      return therapist.full_name.toLowerCase();
    } else if(sort === 'city') {
      return therapist.location.city.toLowerCase();
    }
  })
  $('.list').empty();
  _.each(sortedList, render);
});

function addTherapist() {
$(".add-therapist").on("click",function(e) {
    e.preventDefault();
    $.post(this.href,function(data) {});
  });
}

$('.check').change(function(){
  var check = $(this).data('check');
  if ($(this).is(":checked")){
    currentTherapists = _.filter(currentTherapists, function(therapist) {
      console.log(check);
      return ~services.indexOf(check);
    });
    $('.list').empty();
    _.each(currentTherapists, render);
  } else {
    $('.list').empty();
    filterState();
  }
});
