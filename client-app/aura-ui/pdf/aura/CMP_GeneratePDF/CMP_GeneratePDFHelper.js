({
    getUrlParameter : function (param) {
        var query = decodeURIComponent(window.location.hash.split('?')[1]);
        if(!window.location.hash.split('?')[1]){
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
    }
})