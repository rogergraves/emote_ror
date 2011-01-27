$(document).ready(function() {
    $('#links-dialog').dialog({
        title: 'Links to ScoreCard',
        autoOpen: false,
        closeOnEscape: true,
        modal: true,
        width: 400
    });
    $('#links-dialog').find('input[type=text]').click(function(){
        this.select();
    });
});

function showLinks(scorecard_direct_link){
    var dlg = $('#links-dialog')
    dlg.find('#scorecard_direct_link').val(scorecard_direct_link);
    dlg.find('#scorecard_embed_link').val('<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="'+scorecard_direct_link+'" />');
    dlg.dialog('open');
    return false;
}
