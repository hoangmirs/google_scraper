$(document).ready(function () {
  init_file_upload_form();
  init_keyword_form();
});

function showInfoFileUploadForm(text) {
  $(".infoFileUploadForm").show();
  $(".infoFileUploadForm").text(text);
}
function showInfoKeywordForm(text) {
  $(".infoKeywordForm").show();
  $(".infoKeywordForm").text(text);
}

function init_file_upload_form() {
  $(".infoFileUploadForm").hide();
  $(document).on('submit', '#file-upload-form', function (e) {
    e.preventDefault();
    var file = $("#keywords_file").val();
    if (file == '') {
      showInfoFileUploadForm("Please select a file first.");
      e.preventDefault();
    }
    else {
      var ext = file.split('.').pop().toLowerCase();
      if ($.inArray(ext, ['csv']) == -1) {
        showInfoFileUploadForm("Select a csv file (*.csv).");
        e.preventDefault();
      }
      else {
        submit_file_upload_form();
      }
    }
  });
}

function submit_file_upload_form() {
  $(".infoFileUploadForm").hide();
  var form_data = new FormData($('#file-upload-form')[0]);
  $.ajax({
    type: 'POST',
    url: '/api/v1/search',
    processData: false,
    contentType: false,
    async: false,
    cache: false,
    data: form_data,
    success: function (response) {
      $(location).attr('href', '/search_results')
      alert(response.message);
    },
    error: function (response) {
      showInfoFileUploadForm(response.responseJSON.message);
    }
  });
}

function init_keyword_form() {
  $(".infoKeywordForm").hide();
  $(document).on('submit', '#keyword-form', function (e) {
    e.preventDefault();
    submit_keyword_form();
  });
}

function submit_keyword_form() {
  $(".infoKeywordForm").hide();
  var form_data = new FormData($('#keyword-form')[0]);
  if ($("#keyword").val() == '') {
    showInfoKeywordForm("Please enter a keyword");
    e.preventDefault();
  }
  $.ajax({
    type: 'POST',
    url: '/api/v1/search',
    processData: false,
    contentType: false,
    async: false,
    cache: false,
    data: form_data,
    success: function (response) {
      $(location).attr('href', '/search_results/' + response.message);
    },
    error: function (response) {
      showInfoKeywordForm(response.responseJSON.message);
    }
  });
}
