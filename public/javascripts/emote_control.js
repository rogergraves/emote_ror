$(document).ready(function() {
    $('#emotes-table tr').mouseenter(function(){
        $(this).find('.buttonbar').fadeIn(200);
	$(".hoverover").hide();
    }).mouseleave(function(){
        $(this).find('.buttonbar').fadeOut(100);
    });

    var alerts_dlg = $('#alerts-dialog');
    alerts_dlg.find('form').bind('ajax:success', function(e, data, status) {
        if(status=='success'){
            alert("Settings saved");
            $.modal.close();
        } else {
            alert(data);
        }
    });
    alerts_dlg.find("input[name='respondent_email']").change(function(){
        displayFeedbackPrompt(this.value);
    });

    var alerts_interval_dlg = $('#alerts-interval-dialog');
    alerts_interval_dlg.find('form').bind('ajax:success', function(e, data, status) {
        if(status=='success'){
            alert("Settings saved");
            $.modal.close();
        } else {
            alert(data);
        }
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
    dlg.find('.dialog-title').html('Embed links &amp; QR code for "'+emote_name+'" e.mote&trade; survey');
    dlg.modal({minHeight: 350, minWidth: 600});
    return false;
}

function showDelete(emote_name, emote_code){
    var dlg = $('#delete-dialog');
    dlg.find('.dialog-title').html('Clear Data or Delete "'+emote_name+'"');
    dlg.modal({minHeight: 250, minWidth: 590});
    return false;
}

function showAlerts(emote_name, settings_url){
    $('#alerts-dialog form').attr('action', settings_url);
    $.ajax({
        url: settings_url,
        dataType: 'json',
        success: onAlertSettingsData,
        emote_name: emote_name
    });
    return false;
}

function showAlertsInterval(emote_name, settings_url){
    $('#alerts-interval-dialog form').attr('action', settings_url);
    $.ajax({
        url: settings_url,
        dataType: 'json',
        success: onAlertIntervalSettingsData,
        emote_name: emote_name
    });
    return false;
}

function onAlertIntervalSettingsData(json){
    var dlg = $('#alerts-interval-dialog');
    dlg.find('.dialog-title').html('Alert intervals');

    dlg.find("#activity-updates input:radio").each(function(){
      $(this).attr('checked', $(this).attr('value')==json.activity_report_interval)
    });

    dlg.modal({minHeight: 200, minWidth: 370});
}

function onAlertSettingsData(json){
    var dlg = $('#alerts-dialog');
    dlg.find('.dialog-title').html('Contact for "'+this.emote_name+'"');
    // comment this out for ticket #243
    /*dlg.find("#activity-updates input:radio").each(function(){
      $(this).attr('checked', $(this).attr('value')==json.activity_report_interval)
    });*/

    dlg.find("#respondent-emails input:radio").each(function(){
      $(this).attr('checked', $(this).attr('value')==json.store_respondent_contacts)
    });
    displayFeedbackPrompt(json.store_respondent_contacts);
    var prompt = $.trim(json.feedback_prompt)=='' ? "Start a conversation with us... Enter your email below - we’d be delighted to contact you!" : json.feedback_prompt
    dlg.find("#feedback_prompt").val(prompt);
    dlg.modal({minHeight: 300, minWidth: 370});
}

function displayFeedbackPrompt(visible){
    if(visible=='true'){
        $("#alerts-dialog #feedback-prompt-container").show();
    } else {
        $("#alerts-dialog #feedback-prompt-container").hide();
    }
}

