<?php

/**
 * @file
 * Default theme implementation to display the basic html structure of a single
 * Drupal page.
 *
 * Variables:
 * - $css: An array of CSS files for the current page.
 * - $language: (object) The language the site is being displayed in.
 *   $language->language contains its textual representation.
 *   $language->dir contains the language direction. It will either be 'ltr' or 'rtl'.
 * - $rdf_namespaces: All the RDF namespace prefixes used in the HTML document.
 * - $grddl_profile: A GRDDL profile allowing agents to extract the RDF data.
 * - $head_title: A modified version of the page title, for use in the TITLE
 *   tag.
 * - $head_title_array: (array) An associative array containing the string parts
 *   that were used to generate the $head_title variable, already prepared to be
 *   output as TITLE tag. The key/value pairs may contain one or more of the
 *   following, depending on conditions:
 *   - title: The title of the current page, if any.
 *   - name: The name of the site.
 *   - slogan: The slogan of the site, if any, and if there is no title.
 * - $head: Markup for the HEAD section (including meta tags, keyword tags, and
 *   so on).
 * - $styles: Style tags necessary to import all CSS files for the page.
 * - $scripts: Script tags necessary to load the JavaScript files and settings
 *   for the page.
 * - $page_top: Initial markup from any modules that have altered the
 *   page. This variable should always be output first, before all other dynamic
 *   content.
 * - $page: The rendered page content.
 * - $page_bottom: Final closing markup from any modules that have altered the
 *   page. This variable should always be output last, after all other dynamic
 *   content.
 * - $classes String of classes that can be used to style contextually through
 *   CSS.
 *
 * @see template_preprocess()
 * @see template_preprocess_html()
 * @see template_process()
 REMOVED:
  PUBLIC "-//W3C//DTD XHTML+RDFa 1.0//EN"
  "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"
 */
?><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php print $language->language; ?>" version="XHTML+RDFa 1.0" dir="<?php print $language->dir; ?>"<?php print $rdf_namespaces; ?>>

<head profile="<?php print $grddl_profile; ?>">
  <?php print $head; ?>
  <title><?php print $head_title; ?></title> 
  	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,400italic,600italic' rel='stylesheet' type='text/css'>
    <link href="/css/nsidc-header-2014.css" rel="stylesheet" type="text/css" media="all">
    <link rel="stylesheet" href="/css/nsidc_print.css" type="text/css" media="print" />
  <?php print $styles; ?>
    <!-- files needed for jquery fancybox plugin that delivers popup modal functionality on glossary terms throughout the site -->
	<link href="/scripts/jquery/plugins/jquery.fancybox.css" rel="stylesheet" type="text/css" media="all" />  
  <?php if (theme_get_setting('responsive_respond','nsidc_corporateclean')):
  global $base_path; global $base_root; ?>
  <!--[if lt IE 9]>
  <script src="<?php print $base_root . $base_path . path_to_theme() ?>/js/respond.min.js"></script>
  <![endif]-->
  <?php endif; ?>
  <?php print $scripts; ?>
  	<script type="application/javascript" src="/scripts/global/functionOnload.js"></script>
	<script type="application/javascript" src="/scripts/nsidc-nav.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.selectboxit/3.8.0/jquery.selectBoxIt.min.js"></script>
    <!--build Service Interruption Notice window -->
	<script type="application/javascript" src="/scripts/global/buildModalDiv.js"></script>
    <!-- script to rotate the background image onload -->
	<script type="application/javascript" src="/scripts/global/jquery-background.js"></script>
    <!--#include virtual="/ssi/analytics.ssi" -->
	<!-- google search script -->
	<script type="application/javascript" src="https://www.google.com/cse/brand?form=cref"></script>

	<script src="/scripts/jquery/plugins/jquery.fancybox.js" type="application/javascript"></script>
	<script>
	jQuery(document).ready(function($) {
    if (window.name !== "fancybox-glossary") { // do not load the fancybox script calls popups as it makes loading term within term hokie 
		$.getScript( "/scripts/jquery/plugins/glossary-fancybox-options.js" )
			.done(function( script, textStatus ) {
	   		 console.log( textStatus );
  			})
		}
	});
    </script>
    
    
</head>
<body class="<?php print $classes; ?>" <?php print $attributes;?>>
  <div id="skip-link">
    <a href="#main-content" class="element-invisible element-focusable"><?php print t('Skip to main content'); ?></a>
  </div>
  <div id="wrapper">
  <?php print $page_top; ?>
  <?php print $page; ?>
  <?php print $page_bottom; ?>
  </div><!-- EOF: wrapper -->
</body>
</html>
