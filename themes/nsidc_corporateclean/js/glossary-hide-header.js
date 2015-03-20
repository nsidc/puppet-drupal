jQuery(document).ready(function($) {
if (window.name == "fancybox-glossary") {
	$("#header").css("display", "none");
	$("#banner").css("display", "none");
	$("#footer").css("display", "none");
	$("#sidebar-first").css("display", "none");
	$("#content").css("box-shadow", "none");
	$("body").css("background", "#ffffff");
	$("html").css("background", "none");
	$("#content-inside").css("padding", "0 10px");
	$(".field-name-field-topic").css("display", "none");
	$("#wrapper").css("min-width", "0");
}
});