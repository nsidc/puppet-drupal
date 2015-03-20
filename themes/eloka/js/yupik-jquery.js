jQuery(document).ready(function($) { 
 	$("#yupik-page-nav ul li").hover(function () {
   	 $(this).find('img').toggleClass("active")
	});
	 $("#yupik-page-nav ul li").click(function () {
   	  location.href = $(this).find('a').attr('href');
	});
	$(function(){
    var url = window.location.pathname, 
        urlRegExp = new RegExp(url.replace(/\/$/,'') + "$"); 
        $('#menu a').each(function(){
            if(urlRegExp.test(this.href.replace(/\/$/,''))){
                $(this).parent().parent().css('background-image', 'url(/sites/all/themes/eloka/section_library/yupik-images/nav-bkg-active.png)');
            }
        });
});

	$('.learn-more').click(function() {
  $(this).parent().find('div').toggle('slow', function() {
    // Animation complete.
  	});
	$(this).toggleClass('learn-more-open');
	});
});