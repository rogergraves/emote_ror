$(document).ready(function() {
    var dlg = $('#links-dialog');
    dlg.removeAttr('style').dialog({
        title: 'Link to e.mote&trade;',
        autoOpen: false,
        closeOnEscape: true,
        modal: true,
        width: 550
    });
    dlg.find('input[type=text]').click(function(){
        this.select();
    });
    dlg.find('#open-emote-link').click(function(){
        dlg.dialog('close');
        return true;
    });
});

function showLinks(emote_link){
    var dlg = $('#links-dialog');
    dlg.find('#scorecard_direct_link').val(emote_link);
    dlg.find('#scorecard_embed_link').val('<a href="'+emote_link+'" target="_blank">Click here</a>');
    dlg.find('.feedback-code').each(function(){
      img_path = $(this).parent().prev().find('img').attr('src');
      $(this).val('<a href="'+emote_link+'" target="_blank"><img src="'+img_path+'"/></a>')
    });
    dlg.dialog('open');
    return false;
}
