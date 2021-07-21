({
  onInit: function (component, event, helper) {
  component.set('v.displaySpinner', true);
      
  var recordId = helper.getUrlParameter('c__recordId');
  var documentId = helper.getUrlParameter('c__sapDocNum');
  var data = component.get('v.data');
  if (!documentId || !data)
  {
    component.set('v.displaySpinner', false);
    return;
  }

  component.set('v.documentId', documentId);
  component.set('v.recordId', recordId);

  if(data != null)
  {
    component.set('v.itemId', data.itemNum);
    helper.getVC_Characteristics(component, null);
  }
},
})