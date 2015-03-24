<!-- SOAC MAPS PAGE TEMPLATE -->
<div id="sota-header-wrapper">
   <?php print render($page['header']); ?>
</div>
<div id="sota-page-wrapper">
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
           
            <?php if ($action_links): ?>
            <ul class="action-links">
            <?php print render($action_links); ?>
            </ul>
            <?php endif; ?>
            
			<?php print render($title_prefix); ?>
            <?php if ($title): ?>
            <h1><?php print $title ?></h1>
            <?php endif; ?>
            <?php print render($title_suffix); ?>
            
            <?php if ($tabs): ?><?php print render($tabs); ?><?php endif; ?>

            <div id="text-slide">
			<div id="slide-control" class="ui-icon ui-icon-circle-arrow-w"></div>
			</div>
			<div id="app-view"></div>
            
            <?php print render($page['content']); ?>
            
           
        </div><!-- EOF: #main -->
        
        <?php if ($page['sidebar_second']) :?>
        <!-- #sidebar-second -->
        <div id="sidebar-second" class="grid_3">
        	<?php print render($page['sidebar_second']); ?>
        </div><!-- EOF: #sidebar-second -->
        <?php endif; ?>  

    </div><!-- EOF: #content-inside -->

</div><!-- EOF: #content -->
</div><!-- EOF: #sota-page-wrapper -->
<!-- #footer -->    
<div id="footer">
	<!-- #footer-inside -->
    <div id="footer-inside" class="container_16 clearfix">
    
        <?php print render($page['footer_first']); ?>
       
    </div><!-- EOF: #footer-inside -->

</div><!-- EOF: #footer -->