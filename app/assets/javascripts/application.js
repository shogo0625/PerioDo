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
  $('#show-timer-modal').click(function(){
    $('#timer-modal').fadeIn();
    $('input:visible').eq(0).focus();
  });

  $('#timer-modal').click(function(){
    $(this).fadeOut();
  });

  $('.modal-content').on('click', function(e){
    e.stopPropagation();
  });

  $('.close-modal').click(function(){
    $('#timer-modal').fadeOut();
  });

  var timer = document.getElementById('timer');
  var start = document.getElementById('start');
  var minutes = document.getElementById('minutes');
  var reset = document.getElementById('reset');
  var hideTimer = document.getElementById('hide-timer');

  var startTime;
  var timeLeft;
  var timeToCountDown = 0;
  var timerId;

  function updateTimer(t) {
    var d = new Date(t);
    var m = d.getMinutes();
    var s = d.getSeconds();
    var timerString;
    m = ('0' + m).slice(-2);
    s = ('0' + s).slice(-2);
    timerString = m + ':' + s;
    // timer.textContent = m + ':' + s;
    timer.textContent = timerString;
    document.title = timerString + ' | ' + 'PerioDo';
  }

  function countDown(){
    timerId = setTimeout(function(){
      // var elapsedTime = Date.now() - startTime;
      // timeLeft = timeToCountDown - elapsedTime
      timeLeft = timeToCountDown - (Date.now() - startTime);
      // console.log(timeLeft);
      if (timeLeft < 0) {
        clearTimeout(timerId);
        alert('タイマーがゼロになりました。');
        return;
      }
      updateTimer(timeLeft);
      countDown();
    }, 100);
  }

  function remainedCountDown(){
    timerId = setTimeout(function(){
      timeLeft = timeToCountDown - (Date.now() - startTime);
      if (timeLeft < 0) {
        clearTimeout(timerId);
        sessionStorage.clear();
        alert('タイマーがゼロになりました。');
        return;
      }
      updateTimer(timeLeft);
      remainedCountDown();
    }, 100);
  }

  $(function(){
    $(start).click(function(){
      $('#timer-modal').hide();
      $('#to-set').hide();
      $('#to-finish').show();
      startTime = Date.now();
      if (minutes.value == 0 || minutes.value > 60) {
        alert('1〜60分の間で設定してください。');
        minutes.value = null;
        $('#timer-modal').fadeIn();
        $('input:visible').eq(0).focus();
        return;
      }
      timeToCountDown += minutes.value * 60000;
      updateTimer(timeToCountDown);
      countDown();
    });
  });

  $(function(){
    $(reset).click(function(){
      timeToCountDown = 0;
      $('#to-finish').hide();
      $('#to-set').show();
    });
  });

  $(function(){
    $(hideTimer).click(function(){
      $('#to-finish').slideUp();
      $('#hidden-timer').slideDown();
    });
  });

  $(function(){
    $('#show-timer').click(function(){
      $('#hidden-timer').slideUp();
      $('#to-finish').slideDown();
    });
  });

  function redirectPage(){
    if (timeLeft > 1) {
      sessionStorage.setItem('number', timeLeft);
    }
  }
  window.onbeforeunload = redirectPage;

  window.addEventListener('DOMContentLoaded', function() {
    var count = sessionStorage.getItem('number');
    timeToCountDown = Number(count);
    startTime = Date.now();
    if (count > 0) {
      $('#to-set').hide();
      $('#to-finish').show();
      updateTimer(timeToCountDown);
      remainedCountDown();
    }
  })

});
// ----- タイマー機能 ここまで-----

// ----- ToDoLists ここから-----
$(function(){
  $('#create-tasks').click(function(){
    $('#task-form-modal').fadeIn();
    $('textarea:visible').eq(0).focus();
  });

  $('#task-form-modal').click(function(){
    $(this).fadeOut();
  });

  $('.task-modal-content').on('click', function(e){
    e.stopPropagation();
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

// ----- フォーム共通　制限カウンター ここから-----
$(function(){
 $("#input-text").on("keyup", function() {
   var countNum = String($(this).val().length);
   $("#counter").text(countNum);
 });
});

// ----- フォーム共通　制限カウンター ここまで-----

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


