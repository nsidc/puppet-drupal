
<!-- #banner -->
<div id="banner">

	<?php print render($page['banner']); ?>
      
</div><!-- EOF: #banner -->

<?php if ($page['navigation']) :?>
    <div id="navigation" class="clearfix">
            <?php print drupal_render($page['navigation']); ?>
    	</div>
<?php endif; ?>

<!-- #content -->
<div id="content">
	<!-- #content-inside -->
    <div id="content-inside" class="container_16 clearfix">
    
        <?php if ($page['sidebar_first']) :?>
        <!-- #sidebar-first -->
        <div id="sidebar-first" class="grid_3">
        	<?php print render($page['sidebar_first']); ?>
        </div><!-- EOF: #sidebar-first -->
        <?php endif; ?>
        
        <?php if ($page['sidebar_first'] && $page['sidebar_second']) { ?>
        <div class="grid_10">
        <?php } elseif ($page['sidebar_first'] || $page['sidebar_second']) { ?>
        <div id="main" class="grid_13">
		<?php } else { ?>
        <div id="main" class="grid_16">    
        <?php } ?>
            
            <?php if (theme_get_setting('breadcrumb_display','eloka')): print $breadcrumb; endif; ?>
            
            <?php print render($page['content']); ?>
            
            <?php print $feed_icons; ?>
            
        </div><!-- EOF: #main -->
        
        <?php if ($page['sidebar_second']) :?>
        <!-- #sidebar-second -->
        <div id="sidebar-second" class="grid_3">
        	<?php print render($page['sidebar_second']); ?>
        </div><!-- EOF: #sidebar-second -->
        <?php endif; ?>  

    </div><!-- EOF: #content-inside -->

</div><!-- EOF: #content -->

<!-- #footer -->    
<div id="footer">
<div id="footer-bottom-inside" class="container_16 clearfix">

</div><!-- EOF: footer-bottom-inside -->
</div><!-- EOF: #footer -->