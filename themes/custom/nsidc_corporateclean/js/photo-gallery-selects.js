jQuery(document).ready(function($) {
	var location_selected = $('#edit-location option:selected');
	var project_selected = $('#edit-project option:selected');
	var subject_selected = $('#edit-subject option:selected');
	var photographer_selected = $('#edit-photographer option:selected');
	var search_value = $.trim($('#edit-search').val());
	$('#edit-location').change(function() {
		if(project_selected !== 'All' || subject_selected !== 'All' || photographer_selected !== 'All' || search_value !== '') {
		$('#edit-project').val('All');
		$('#edit-subject').val('All');
		$('#edit-photographer').val('All');
		$('#edit-search').val('');
		}
	});
	$('#edit-project').change(function() {
		if(location_selected !== 'All' || subject_selected !== 'All' || photographer_selected !== 'All' || search_value !== '') {
		$('#edit-location').val('All');
		$('#edit-subject').val('All');
		$('#edit-photographer').val('All');
		$('#edit-search').val('');
		}
	});
		$('#edit-subject').change(function() {
		if(location_selected !== 'All' || project_selected !== 'All' || photographer_selected !== 'All' || search_value !== '') {
		$('#edit-location').val('All');
		$('#edit-project').val('All');
		$('#edit-photographer').val('All');
		$('#edit-search').val('');
		}
	});
		$('#edit-photographer').change(function() {
		if(location_selected !== 'All' || subject_selected !== 'All' || project_selected !== 'All' || search_value !== '') {
		$('#edit-location').val('All');
		$('#edit-subject').val('All');
		$('#edit-project').val('All');
		$('#edit-search').val('');
		}
	});
	$('input[name=search]').change(function(){
		if(location_selected !== 'All' || subject_selected !== 'All' || project_selected !== 'All' || photographer_selected !== 'All') {
			$('#edit-location').val('All');
			$('#edit-project').val('All');
			$('#edit-subject').val('All');
			$('#edit-photographer').val('All');
		}
	});
});