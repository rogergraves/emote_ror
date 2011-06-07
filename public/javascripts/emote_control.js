$(document).ready(function() {
    var link_dlg = $('#links-dialog');
    link_dlg.removeAttr('style').dialog({
        autoOpen: false,
        closeOnEscape: true,
        modal: true,
        width: 600,
        height: 370
    });
    
    var delete_dlg = $('#delete-dialog');
    delete_dlg.removeAttr('style').dialog({
        autoOpen: false,
        closeOnEscape: true,
        modal: true,
        width: 590,
        height: 250
    });    

    var alerts_dlg = $('#alerts-dialog');
    alerts_dlg.find('form').bind('ajax:success', function(e, data, status) {
        if(status=='success'){
            alert("Settings saved");
            $('#alerts-dialog').dialog('close');
        } else {
            alert(data);
        }
    });
    alerts_dlg.removeAttr('style').dialog({
        title: "Activity Alerts",
        autoOpen: false,
        closeOnEscape: true,
        modal: true,
        width: 400,
        height: 300
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
    dlg.find('#qr-code').attr('src', '/images/qr/emote_'+emote_code+'_qr.png')
    dlg.find('#download-link').attr('href', '/account/surveys/'+emote_code+'/get_qrcode')
    dlg.dialog({title: 'Embed links &amp; QR code for "'+emote_name+'" e.mote&trade; survey'});
    dlg.dialog('open');
    return false;
}

function showDelete(emote_name, emote_code){
    var dlg = $('#delete-dialog');
    dlg.dialog({title: 'Clear Data or Delete "'+emote_name+'"'});
    dlg.dialog('open');
    return false;
}

function showAlerts(emote_name, settings_url){
    $('#alerts-dialog form').attr('action', settings_url);
    $.ajax({
        url: settings_url,
        dataType: 'json',
        success: onAlertSettingsData
    });
    return false;
}

function onAlertSettingsData(json){
    var dlg = $('#alerts-dialog');
    //dlg.dialog({title: 'Alerts for "'+emote_name+'"'});
    dlg.find("#activity-updates input:radio").each(function(){
      $(this).attr('checked', $(this).attr('value')==json.activity_report_interval)
    });
    dlg.find("#respondent-emails input:radio").each(function(){
      $(this).attr('checked', $(this).attr('value')==json.store_respondent_contacts)
    });
    dlg.dialog('open');
}


