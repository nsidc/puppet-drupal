jQuery(document).ready(function($) { 

  var player_id = "eloka-video";
  var options = { "controls": true, "autoplay": false, "preload": "auto" }
  var video_player = videojs(player_id, options);
  var textTrack = video_player.textTracks()[0];

 videojs(player_id).on('play', function(e) {

    // Switch location of captions based on existence of 'subtitle_display' div.
    // 'showing' for captions inside video, 'hidden' for captions outside video.
    // TODO: Find a way to override behavior of subtitles button so
    // that it hides/shows captions when displayed outside video.
    if ($('#subtitle_display').length) {
      textTrack.hide();
      $('#subtitle_display').hide();
      videojs(player_id).getChild('controlBar').subtitlesButton.hide();
    } else {
      textTrack.show();
      $('#subtitle_display').hide();
      videojs(player_id).getChild('controlBar').subtitlesButton.show();
    }

    var cue = textTrack.activeCues()[0];

    if (cue) {
      $('#subtitle_display').show();
      $('#subtitle_display').text(cue.text);
    }

    textTrack.on('cuechange', function () {
      $('#subtitle_display').show();
      var cue = this.activeCues()[0];
      $('#subtitle_display').text(cue.text);
    });
  }, true);
});
