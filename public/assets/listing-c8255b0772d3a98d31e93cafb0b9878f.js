function setInitialState(e){$("#filter-state").val(e)}function render(e){var t=e.location_street1+" "+e.location_street2+" "+e.location_city+" "+e.location_state+" "+e.location_zip;t=t.replace(null,"");var i=$("<li><h3>"+e.name1+"</h3><a href='#return-check'><i class='fa fa-plus-circle add-map-pin' style='float:right' data-street='"+t+"'></i></a><p>"+t+"<br/><a class='more-information' href='/facilities/"+e.id+"'>More Information</a><a class='add-facility' href='/facility/save/"+e.id+"' remote: true> Save Facility</a></li>");i.find(".add-map-pin").on("click",function(){var e=$(this).data("street");addMarker(e)}),$(".list").append(i),addFacility()}function filterState(){currentFacilities=_.filter(facilities,function(e){return e.location_state===state}),$(".list").empty(),_.each(currentFacilities,render)}function addFacility(){$(".add-facility").on("click",function(e){e.preventDefault(),$.post(this.href,function(){})})}$("#filter-none").on("click",function(){$(".list").empty(),_.each(firstFacilities,render)}),$("#filter-state").on("change",function(){state=$("#filter-state").val(),$(".check").prop("checked",!1),filterState()}),$(".search").keyup(function(){var e=$(this).val().toLowerCase();if(e){var t=_.filter(currentFacilities,function(t){var i=t.services_text1+t.services_text2+t.services_text3+t.services_text4+t.services_text5+t.services_text6+t.services_text7,a=(t.name1+t.location_state+t.location_city+t.location_zip+i).toLowerCase();return~a.indexOf(e)});$(".list").empty(),_.each(t,render)}else $(".list").empty(),_.each(currentFacilities,render)}),$(".sort").on("click",function(){var e=$(this).data("sort"),t=_.sortBy(currentFacilities,function(t){return"name"===e?t.name1.toLowerCase():"city"===e?t.location_city.toLowerCase():void 0});$(".list").empty(),_.each(t,render)}),$(".check").change(function(){var e=$(this).data("check");$(this).is(":checked")?(currentFacilities=_.filter(currentFacilities,function(t){var i=(t.services_text1+t.services_text2+t.services_text3+t.services_text4+t.services_text5+t.services_text6+t.services_text7).toLowerCase();return console.log(e),~i.indexOf(e)}),$(".list").empty(),_.each(currentFacilities,render)):($(".list").empty(),filterState())});