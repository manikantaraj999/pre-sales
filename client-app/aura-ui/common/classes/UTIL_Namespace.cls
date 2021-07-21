public with sharing class UTIL_Namespace
{
    /// @description Returns the namespace prefix (e.g. ENSX_Logging__) when there is a namespace (managed package)
    /// Returns empty string when there is no namespace (unmanaged package)
    static public String namespacePrefix
    {
        get
        {
            if (null == namespacePrefix)
            {
                // PageReference behavior is different between managed and unmanaged code.
                // In managed code it modifies the URL to add the namespace to the page URL,
                // so /apex/page becomes /apex/ENSX_Logging__page.
                namespacePrefix =
                    new PageReference('/apex/page')
                    .getUrl()
                    .replaceFirst('^/apex/','')
                    .replaceFirst('page$','');
            }
            return namespacePrefix;
        }
        private set;
    }
}