	jQuery(document).ready(function($) {
		$(function() {
  			$('.more-less').truncate({maxLength: 260});
		});
		$('#slide-control').click(function() {
			$( "#text" ).last().toggle("slide", { direction: "left" }, 1000); 
			if ( $( this ).hasClass("ui-icon-circle-arrow-w") ) {
				$( this ).switchClass( "ui-icon-circle-arrow-w", "ui-icon-circle-arrow-e", 1000, "easeInOutQuad" );
				$('#text-slide').animate({ width: "88px" }, 1000 );
				$( this ).before( "<span class='show-text'>Show&nbsp;Text</span>" );
				$('.more-less').css("display", "none");
			} else {
				$( this ).switchClass( "ui-icon-circle-arrow-e", "ui-icon-circle-arrow-w", 1000, "easeInOutQuad" );
				$( '#text-slide').animate({ width: "295px" }, 1000 );
				$(".show-text").remove();
				$('.more-less:first').css("display", "none");
				$('.more-less:last').css("display", "block");
			};
		});
		$(function() {
    		$(window).resize(function() {
        	var sotaHeight = $(this).height() - 64;
        	$("#sota-page-wrapper").css("height", sotaHeight);
    		}).resize();
		});
    });