// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

spud.admin.banner_sets = new function(){

  var self = this;
  var bannerSetEditId = false;

  this.init = function(){
    $('.spud_banner_sets_add_new').on('click', self.clickedAddNewBannerSet);
    $('.spud_admin_banner_sets_list').on('click', '.spud_banner_sets_edit', self.clickedEditBannerSet);
    $('.modal-body').on('submit', '.spud_banner_set_form', self.submittedBannerSetForm);
  };

  self.clickedAddNewBannerSet = function(e){
    e.preventDefault();
    bannerSetEditId = false;
    $.ajax({
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(html, textStatus, jqXHR){
        displayModalDialogWithOptions({
          title: 'New Banner Set',
          html: html
        });
      }
    });
  };

  self.clickedEditBannerSet = function(e){
    e.preventDefault();
    bannerSetEditId = parseInt($(this).parents('li').attr('data-id'), 10);
    $.ajax({
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(html, textStatus, jqXHR){
        displayModalDialogWithOptions({
          title: 'Edit Banner Set',
          html: html
        });
      }
    });
  };

  self.submittedBannerSetForm = function(e){
    e.preventDefault();
    var form = $(this);
    $.ajax({
      url: form.attr('action'),
      data: form.serialize(),
      type: 'post',
      dataType: 'html',
      success: self.savedBannerSetSuccess,
      error: self.savedBannerSetError
    });
  };

  self.savedBannerSetSuccess = function(html){
    if(bannerSetEditId){
      var item = $('.spud_admin_banner_sets_list_item[data-id="'+bannerSetEditId+'"]');
      item.replaceWith(html);
    }
    else{
      $('.spud_admin_banner_sets_list').append(html);
    }
    hideModalDialog();
  };

  self.savedBannerSetError = function(jqXHR, textStatus, errorThrown){
    if(jqXHR.status == 422){
      var html = jqXHR.responseText;
      $('.spud_banner_set_form').replaceWith(html);
    }
    else{
      if(window.console){
        console.error('Oh Snap:', arguments);
      }
    }
  };
}();