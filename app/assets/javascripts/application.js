// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require popper
//= require bootstrap-sprockets
//= require_tree .

// ----- タイマー機能 ここから-----

$(function() {
  $('#show-timer').click(function(){
    $('#timer-modal').fadeIn();
    $('input:visible').eq(0).focus();
  });

  $('.close-modal').click(function(){
    $('#timer-modal').fadeOut();
  });

});
// ----- タイマー機能 ここまで-----

// ----- ToDoLists ここから-----
$(function(){
  $('#create-tasks').click(function(){
    $('#task-form-modal').fadeIn();
    $('textarea:visible').eq(0).focus();
  });

  $('#close-form-modal').click(function(){
    $('#task-form-modal').fadeOut();
  });

  $('#show-tasks').click(function(){
    $(this).hide();
    $('#hide-tasks').fadeIn();
    $('#todolists').slideDown();
    $('textarea:visible').eq(0).focus();
  });

  $('#hide-tasks').click(function(){
    $(this).hide();
    $('#show-tasks').fadeIn();
    $('#todolists').slideUp();
  });
});
// ----- ToDoLists ここまで-----

// ----- 画像プレビュー ここから-----
$(function() {
  function readURL(input) {
      if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
  $('#preview-noimage').attr('src', e.target.result).show();
  $('#preview-image').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
      }
  }
  $('#post-image').change(function(){
      readURL(this);
  });
});
// ----- 画像プレビュー ここまで-----

// ----- コメント投稿フォーム表示 ここから-----
$(function(){
  $('.fake-comment-field').click(function(){
    $('#show-comment-form').hide();
    $('.comment-form').fadeIn();
    $('textarea:visible').eq(0).focus();
  });

  $('#close-form').click(function(){
    $('.comment-form').hide();
    $('#show-comment-form').fadeIn();
  });
});
// ----- コメント投稿フォーム表示 ここまで-----

// ----- マイページ タブメニュー ここから-----
$(function(){
  $('.tab-btn').click(function(){
    $('.tab-content').removeClass('active-content');
    $($(this).attr("href")).addClass('active-content');
    $('.tab-btn').removeClass('active-btn');
    $(this).addClass('active-btn');
  });
});

// ----- マイページ タブメニュー ここまで-----




