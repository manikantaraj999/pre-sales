({
    // The pagerChangedEvent is handled by parent components.
    // Typically this would trigger a data update.
    fireChangedEvent: function (component, options) {
        var evt = component.getEvent('pagerChangedEvent')
        evt.setParams({ options: options })
        evt.fire()
    }
})