jQuery(document).ready(function($) {
 
 
	// TOGGLE SCRIPT
	$(".show-more").hide();

	$("a.more-link").click(function(event){
		$(this).parents(".more").find(".show-more").toggle("normal");
		$(this).toggleClass("more-link-arrow-up");
 
		// Stop the link click from doing its normal thing
		return false;
	}); // END TOGGLE
	
		// TOGGLE SCRIPT FOR NESTED 
	$(".show-more2").hide();
 
	$("a.more-link2").click(function(event){
		$(this).parents(".more2").find(".show-more2").toggle("normal");
		$(this).toggleClass("more-link-arrow-up");
 

		// Stop the link click from doing its normal thing
		return false;
	}); // END TOGGLE

   }); // END 
   
   // JavaScript Document