var header = undefined;
var menu = undefined;
var menuButton = undefined;
 
jQuery(document).ready(function($) {
    header = $("#header");
    menu = $("#header #nsidc-menu");
    menuButton = $("<div id='skip-nav'><a href='#'>menu</a></div>");
 //   header.append(menuButton);
 	$("#header").append(menuButton);
//	menuButton.click(showMenu);
	$("#skip-nav").click(function () {
	$("#header #nsidc-menu").toggle();
	$("#header #nsidc-search").toggle();
	$(this).toggleClass("menu-open");
	$(this).find("a").toggleClass("close-menu");
});
});
 
//function showMenu (event) {
  //  if (menu.is(":visible"))
    //    menu.slideUp({complete:function(){$(this).css('display','')}});
   // else
     //   menu.slideDown();
// }