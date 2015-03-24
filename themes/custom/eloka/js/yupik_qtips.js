jQuery(document).ready(function($) 
{
	// Make sure to only match links to wikipedia with a rel tag
   $('a[rel="modal"]').each(function()
   {
      // We make use of the .each() loop to gain access to each element via the "this" keyword...
      $(this).qtip(
      {
         content: {
            // Set the text to an image HTML string with the correct src URL to the loading image you want to use
            text: "<p>In their roles as translators, Alice Rearden and Marie Meade offer distinctive strategies for bridging differences between Yup'ik and English without erasing them. Their goal throughout has been a 'natural sounding,' free translation, as opposed to either literal translation (at one extreme) or paraphrasing (at the other). Paraphrasing may communicate some of the sense of the original, but such interpretive translations modify the original to the point where the speaker's voice is alternately erased or transformed. Literal, word-for-word translation is also inadequate. At best it is awkward, and at worst it makes no sense. Alice's and Marie's translations employ a free style in which each speaker's choice of words is respected, while word order and sentence structure are modified where necessary to communicate his original meaning. </p>",
            title: {
               text: ' ' + $(this).text(), // Give the tooltip a title using each elements text
               button: true
            }
         },
         position: {
            at: 'top right', // Position the tooltip above the link
            my: 'center left',
            adjust: { screen: true } // Keep the tooltip on-screen at all times
         },
         show: {
            event: 'click',
            solo: true // Only show one tooltip at a time
         },
         hide: 'unfocus',
         style: {
            classes: 'ui-tooltip-wiki ui-tooltip-light ui-tooltip-shadow',
         }
      })
 
      // Make sure it doesn't follow the link when we click it
      .click(function() { return false; });
   });
});