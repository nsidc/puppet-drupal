/*
Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

/*
 * This file is used/requested by the 'Styles' button.
 * The 'Styles' button is not enabled by default in DrupalFull and DrupalFiltered toolbars.
 */
if(typeof(CKEDITOR) !== 'undefined') {
    CKEDITOR.addStylesSet( 'drupal',
    [
            /* Block Styles */

            // These styles are already available in the "Format" drop-down list, so they are
            // not needed here by default. You may enable them to avoid placing the
            // "Format" drop-down list in the toolbar, maintaining the same features.
            /*
            { name : 'Paragraph'		, element : 'p' },
            { name : 'Heading 1'		, element : 'h1' },
            { name : 'Heading 2'		, element : 'h2' },
            { name : 'Heading 3'		, element : 'h3' },
            { name : 'Heading 4'		, element : 'h4' },
            { name : 'Heading 5'		, element : 'h5' },
            { name : 'Heading 6'		, element : 'h6' },
            { name : 'Preformatted Text', element : 'pre' },
            { name : 'Address'			, element : 'address' },
            */

            { name : 'Blue Callout'		, element : 'span', styles : { 'color' : 'Blue', 'font-weight' : 'bold' } },
            { name : 'Red Highlight'		, element : 'span', styles : { 'color' : 'Red', 'font-weight' : 'bold' } },
			{ name : 'H3 Line Below Heading'		, element : 'h3', styles : { 'border-bottom' : '1px solid #cccccc', 'padding-bottom' : '5px' } },
			

            /* Inline Styles */

            // These are core styles available as toolbar buttons. You may opt enabling
            // some of them in the "Styles" drop-down list, removing them from the toolbar.
            /*
            { name : 'Strong'			, element : 'strong', overrides : 'b' },
            { name : 'Emphasis'			, element : 'em'	, overrides : 'i' },
            { name : 'Underline'		, element : 'u' },
            { name : 'Strikethrough'	, element : 'strike' },
            { name : 'Subscript'		, element : 'sub' },
            { name : 'Superscript'		, element : 'sup' },
            */

            { name : 'P Clear Left'	, element : 'p', attributes : { 'class' : 'clear-left' } },
            { name : 'P Clear Right', element : 'p', attributes : { 'class' : 'clear-right' } },
			{ name : 'P Clear Both'	, element : 'p', attributes : { 'class' : 'clear-both' } },

            { name : 'Big'				, element : 'big' },
            { name : 'Small'			, element : 'small' },
            { name : 'Typewriter'		, element : 'tt' },

            { name : 'Computer Code'	, element : 'code' },
            { name : 'Variable'			, element : 'var' },

            { name : 'Cited Work'		, element : 'cite' },
            { name : 'Inline Quotation'	, element : 'q' },

            /* Object Styles */

            { name : 'Image on Left'	, element : 'img', attributes :  {'class' : 'img-left caption' } },

            { name : 'Image on Right'	, element : 'img', attributes :  {'class' : 'img-right caption' } },
			
			{ name : 'Photo Box Left'	, element : 'div', attributes :  {'class' : 'photo-box-left' } },
			
			{ name : 'Photo Box Right'	, element : 'div', attributes :  {'class' : 'photo-box' } },
			
			{ name : 'Glossary Link'	, element : 'a', attributes :  {'class' : 'glossary' } },
			
			{ name : 'Image No-Border Left'	, element : 'img', attributes :  {'class' : 'img-left img-no-border-left' } },
			
			{ name : 'Image No-Border Right'	, element : 'img', attributes :  {'class' : 'img-right img-no-border-right' } }
						

    ]);
}