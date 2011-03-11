$(document).ready(function() {
    var dlg = $('#links-dialog');
    dlg.removeAttr('style').dialog({
        autoOpen: false,
        closeOnEscape: true,
        modal: true,
        width: 570,
        height: 400
    });
});

function showLinks(emote_name, emote_link, emote_code){
    var embed_js =
        "<div id='emote-this-button'></div>"+
        "<script type='text/javascript'>"+
        "emote_uid = '"+emote_code+"';"+
        "emote_link_content = \"%CONTENT%\";"+
        "var jsHost = (('https:' == document.location.protocol) ? 'https://ssl.' : 'http://');"+
        "document.write(unescape('%3Cscript src=\"' + jsHost + 'emotethis.com/js/emote.js\" type=\"text/javascript\"%3E%3C/script%3E'));"+
        "</script>";

    var dlg = $('#links-dialog');
    dlg.find('#scorecard_direct_link').val(emote_link);
    dlg.find('#scorecard_embed_link').val(embed_js.replace(/%CONTENT%/, 'Click here'));
    dlg.find('.feedback-code').each(function(){
      img_path = $(this).parent().prev().find('img').attr('src');
      $(this).val(embed_js.replace(/%CONTENT%/, "<img src='"+img_path+"' border='0'/>"))
    });
    dlg.dialog({title: 'Embed links for "'+emote_name+'" e.mote&trade; survey'});
    dlg.dialog('open');
    return false;
}
