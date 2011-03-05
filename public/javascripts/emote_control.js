$(document).ready(function() {
    var dlg = $('#links-dialog');
    dlg.removeAttr('style').dialog({
        autoOpen: false,
        closeOnEscape: true,
        modal: true,
        width: 550,
        height: 400
    });
    dlg.find('textarea').click(function(){
        this.select();
    });
});

function showLinks(emote_name, emote_link){
    var dlg = $('#links-dialog');
    dlg.find('#scorecard_direct_link').val(emote_link);
    dlg.find('#scorecard_embed_link').val('<a href="'+emote_link+'" target="_blank">Click here</a>');
    dlg.find('.feedback-code').each(function(){
      img_path = $(this).parent().prev().find('img').attr('src');
      $(this).val('<a href="'+emote_link+'" target="_blank"><img border="0" src="'+img_path+'"/></a>')
    });
    dlg.dialog({title: 'Embed links for "'+emote_name+'" e.mote&trade; survey'});
    dlg.dialog('open');
    return false;
}
