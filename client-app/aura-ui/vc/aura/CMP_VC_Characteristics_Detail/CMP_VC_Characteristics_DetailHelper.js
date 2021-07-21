({

  getVC_Characteristics: function (component, pagingOptions) {

    var recordId = component.get('v.recordId');
    var documentId = component.get('v.documentId');
    var itemId = component.get('v.itemId');

    var action = component.get("c.getVC_Characteristics_Detail");
    action.setParams({
      accountId: recordId, 
      documentId: documentId,
      itemId:itemId
    });

    action.setCallback(this, function(data) {
      if (data.getReturnValue()) {
        var response = data.getReturnValue();
        component.set('v.vcCharacteristicsList', response.data);
        component.set('v.messages', response.messages);
        component.set('v.displaySpinner', false);
      }
      else //nothing returned from Apex call
      {
          var labelReference = $A.get("$Label.c.LBL_Error_NoResponse");
          var noResponse = {message: labelReference, messageType: "ERROR"};
          component.set('v.messages', noResponse);
          component.set('v.displaySpinner', false);
      }
    });
      
    $A.enqueueAction(action);
      

  },

  getUrlParameter : function (param) {
    var query = decodeURIComponent(window.location.hash.split('?')[1]);

    if (!window.location.hash.split('?')[1]) {
      var url = window.location.toString();
      query = decodeURIComponent(url.split('?')[1])
    }
      var params = query.split('&');
    
    for (var i = 0; i < params.length; i++) {
        var currentParam = params[i].split('=');
        if (currentParam[0] === param) {
            return currentParam[1] === undefined ? true : currentParam[1];
        }
    }
    
    return '';
  },

})