<?php

/**
 * @file
 * Customized implementation to display a single Drupal page while offline.
 *
 * All the available variables are mirrored in html.tpl.php and page.tpl.php.
 * Some may be blank but they are provided for consistency.
 *
 * @see template_preprocess()
 * @see template_preprocess_maintenance_page()
 *
 * @ingroup themeable
 */
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php print $language->language ?>" lang="<?php print $language->language ?>" dir="<?php print $language->dir ?>">

<head>
  <title><?php print $head_title; ?></title>
  <?php print $head; ?>
 <link href="/sites/all/themes/eloka/style.css" rel="stylesheet" type="text/css" /> 
    <style>
html {
	background-image: url(/sites/eloka-arctic.org/files/background_reindeer_0.jpg);
	background-attachment: fixed;
background-color: rgb(205, 223, 229);
background-size: cover;
background-position: 50% 0%;
background-repeat: no-repeat no-repeat;
}
#wrapper {
    margin-left: auto;
    margin-right: auto;
    width: 40%;
	margin-top: 10%;
}
#header, #footer-wrapper, #content {
    clear: both;
    height: auto;
	width: 100%;
	box-sizing:border-box;
	-moz-box-sizing: border-box;
}
#header {
	background: #fff;
}

#content {
    clear: both;
    color: #06070B;
    float: left;
    padding: 20px 40px;
	background: #fff;
}

#footer {
	color: #fff;
	padding: 20px;
	background: transparent;
}
#footer-text {
float: left;
color: #fff;
text-shadow: 1px 1px #000;
font-family: Geneva, Arial, Verdana, sans-serif;
font-size: 0.85em;
width: 100%;
margin: 20px 0 0 0px;
text-align: center;
}
    </style>

</head>
<body class="<?php print $classes; ?>">
  <div id="wrapper" class="clearfix">
  <div id="header">
	<div id="header-inside-left" class="grid_4"><div id="eloka-logo"><img alt="" src="/sites/eloka-arctic.org/files/images/eloka_logo.png"></div></div>
  </div> <!-- /header -->

        <div id="content">
          <h1 class="title" id="page-title">We'll be back soon.</h1>
          
          <p><?php print $content; ?></p>
        </div> <!-- /content -->
  </div> <!-- /wrapper -->
    <div id="footer-wrapper">
      <div id="footer">
                  <p id="footer-text">ELOKA is a collaborative international effort; the Web site is hosted by the National Snow and Ice Data Center. Contact:&nbsp;<a href="mailto:eloka@nsidc.org">eloka@nsidc.org</a></p>
      </div> <!-- /footer -->
    </div> <!-- /footer-wrapper -->



</body>
</html>
