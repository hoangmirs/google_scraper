$(document).ready(function () {
  init_query_form();
});

function showInfoLinkQueries(text) {
  $(".infoLinkQueries").show();
  $(".infoLinkQueries").text(text);
}

function init_query_form() {
  $(".infoLinkQueries").hide();
  $(".infoLinkQueryResult").hide();
  $(document).on('submit', '#query-form', function (e) {
    e.preventDefault();
    $(".infoLinkQueryResult").hide();
    $(".infoLinkQueries").hide();
    if ($("#keyword").val() == '') {
      showInfoLinkQueries("Please enter a keyword");
      e.preventDefault();
    } else {
      submit_query_form();
    }
  });
}

function submit_query_form() {
  var form_data = $('#query-form').serialize();
  $.ajax({
    type: 'GET',
    url: '/api/v1/link_queries',
    processData: false,
    contentType: false,
    async: false,
    cache: false,
    data: form_data,
    success: function (response) {
      showResult(response);
    },
    error: function (response) {
      showInfoLinkQueries(response.responseJSON.message);
    }
  });
}

function showResult(result) {
  var html_string = "Result: " + result.length;
  html_string += "<ul>";
  for (var i = 0; i < result.length; i++) {
    link = result[i];
    str = "<li>" + link.url + " | " + link.link_type + " | " + link.keyword + "</li>";
    html_string += str;
  }
  html_string += "</ul>";
  $(".infoLinkQueryResult").html(html_string);
  $(".infoLinkQueryResult").show();
}
