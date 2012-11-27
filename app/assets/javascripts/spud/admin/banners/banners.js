// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

spud.admin.banners = new function(){

  var self = this;
  var html5upload = false;
  var bannerEditId = false;

  this.init = function(){
    if(typeof(FormData) != 'undefined'){
      html5upload = true;
    }
    $('.spud_banner_add_new').on('click', self.clickedAddNewBanner);
    $('.spud_banner_set_banners_container').on('click', '.spud_banner_set_banner_item_edit', self.clickedEditBanner);
    $('.spud_banner_set_banners_container').on('click', '.spud_banner_set_banner_item_delete', self.clickedDeleteBanner);
    $('.modal-body').on('submit', '.spud_banner_form', self.submittedBannerForm);

    $('.spud_banner_set_banners_container').sortable({
      stop: self.sortedBanners
    });
  };

  self.clickedAddNewBanner = function(e){
    e.preventDefault();
    bannerEditId = false;
    $.ajax({
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(html, textStatus, jqXHR){
        displayModalDialogWithOptions({
          title: 'Upload Banner',
          html: html
        });
      }
    });
  };

  self.clickedEditBanner = function(e){
    e.preventDefault();
    bannerEditId = parseInt($(this).parents('.spud_banner_set_banner_item').attr('data-id'), 10);
    $.ajax({
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(html, textStatus, jqXHR){
        displayModalDialogWithOptions({
          title: 'Edit Banner',
          html: html
        });
      }
    });
  };

  self.clickedDeleteBanner = function(e){
    e.preventDefault();
    var el = $(this);
    $.ajax({
      url: el.attr('href'),
      type: 'post',
      data: {'_method':'delete'},
      complete: function(jqXHR, textStatus){
        var parent = el.parents('.spud_banner_set_banner_item');
        parent.fadeOut(200, function(){
          parent.remove();
        });
        if(textStatus != 'success'){
          console.warn('Something went wrong:', jqXHR);
        }
      }
    });
  };

  self.submittedBannerForm = function(e){
    if(html5upload){
      e.preventDefault();

      var form = $(this);
      var fd = new FormData();
      fd.append('_method', form.find('[name=_method]').val());
      fd.append('authenticity_token', form.find('[name=authenticity_token]').val());
      fd.append('spud_banner[link_to]', form.find('#spud_banner_link_to').val());
      fd.append('spud_banner[link_to_class]', form.find('#spud_banner_link_to_class').val());
      fd.append('spud_banner[target]', form.find('#spud_banner_target').val());
      fd.append('spud_banner[title]', form.find('#spud_banner_title').val());
      fd.append('spud_banner[alt]', form.find('#spud_banner_alt').val());

      var file = form.find('#spud_banner_banner')[0].files[0];
      if(file){
        fd.append('spud_banner[banner]', file);
      }

      var xhr = new XMLHttpRequest();
      xhr.upload.addEventListener('progress', self.onFileUploadProgress);
      xhr.addEventListener('load', self.onFileUploadComplete);
      xhr.addEventListener('error', self.onFileUploadError);
      xhr.addEventListener('abort', self.onFileUploadAbort);
      xhr.open('POST', form.attr('action'));
      xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');

      $('.spud_banner_upload_progress').show();
      xhr.send(fd);
      return false;
    }
  };

  self.onFileUploadProgress = function(e){
    var percent = Math.round(e.loaded * 100 / e.total);
    var progress = $('.spud_banner_upload_progress');
    progress.find('.bar').css({width: percent + '%'});
    if(percent == 100){
      progress.addClass('progress-success');
    }
  };

  self.onFileUploadComplete = function(e){
    switch(this.status){
      case 200:
        self.onLegacyUploadComplete(e.target.response);
        break;
      case 422:
        self.onLegacyUploadError(e.target.response);
        break;
      default:
        window.alert("Whoops! Something has gone wrong.");
    }
  };

  self.onFileUploadError = function(e){

  };

  self.onFileUploadAbort = function(e){

  };

  // Non-html5 upload
  self.onLegacyUploadComplete = function(html){
    if(bannerEditId){
      var item = $('.spud_admin_banner_item[data-id="'+bannerEditId+'"]');
      item.replaceWith(html);
    }
    else{
      $('.spud_banner_set_banners_container').append(html);
    }
    hideModalDialog();
  };

  self.onLegacyUploadError = function(html){
    $('.spud_banner_form').replaceWith(html);
  };

  self.sortedBanners = function(e, ui){
    var ids = [];
    $('.spud_banner_set_banner_item').each(function(){
      ids.push($(this).attr('data-id'));
    });
    $.ajax({
      url: '/spud/admin/banners/sort',
      type: 'post',
      data: {spud_banner_ids:ids, _method:'put'}
    });
  };
}();