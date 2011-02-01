$(document).ready(function() {
    $('#links-dialog').removeAttr('style').dialog({
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
    dlg.find('#scorecard_embed_link').val('<a href="'+scorecard_direct_link+'" target="emote">Click here</a>');
    dlg.find('#open-emote-link').attr('href', scorecard_direct_link);
    dlg.dialog('open');
    return false;
}
