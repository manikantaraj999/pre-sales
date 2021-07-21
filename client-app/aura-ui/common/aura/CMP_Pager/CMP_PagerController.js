({
    onOptionsChange: function (component, event, helper) {
        var options = event.getParam('value')
        var totalPages = options.totalRecords == 0 ? 0 : Math.ceil(options.totalRecords / options.pageSize)
        var isPreviousEnabled = options.pageNumber > 1
        var isNextEnabled = options.pageNumber < totalPages

        component.set('v.pageSize', options.pageSize)
        component.set('v.totalPages', totalPages)
        component.set('v.isPreviousEnabled', isPreviousEnabled)
        component.set('v.isNextEnabled', isNextEnabled)
    },

    onPageSizeChange: function (component, event, helper) {
        var options = component.get('v.options')
        options.pageSize = parseInt(component.find('pageSize').get('v.value'))
        options.pageNumber = 1
        helper.fireChangedEvent(component, options)
    },

    gotoPreviousPage: function (component, event, helper) {
        var options = component.get('v.options')
        options.pageNumber -= 1
        options.pageNumber = Math.max(options.pageNumber, 1)
        helper.fireChangedEvent(component, options)
    },

    gotoNextPage: function (component, event, helper) {
        var options = component.get('v.options')
        var totalPages = component.get('v.totalPages')
        options.pageNumber += 1
        options.pageNumber = Math.min(options.pageNumber, totalPages)
        helper.fireChangedEvent(component, options)
    },

    gotoFirstPage: function (component, event, helper) {
        var options = component.get('v.options')
        options.pageNumber = 1
        helper.fireChangedEvent(component, options)
    },

    gotoLastPage: function (component, event, helper) {
        var options = component.get('v.options')
        options.pageNumber = component.get('v.totalPages')
        helper.fireChangedEvent(component, options)
    }
})