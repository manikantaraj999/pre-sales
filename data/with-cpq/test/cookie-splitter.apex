String data = 'MYSAPSSO2=AjQxMDMBABhFAE4ATwBTAEkAWABUAEUAUwBUACAAIAACAAY4ADAAMAADABBEAEUAVgAgACAAIAAgACAABAAYMgAwADEAOQAwADUAMAA2ADIAMAAyADEABQAEAAAACAYAAlgACQACRQD%2fAPswgfgGCSqGSIb3DQEHAqCB6jCB5wIBATELMAkGBSsOAwIaBQAwCwYJKoZIhvcNAQcBMYHHMIHEAgEBMBowDjEMMAoGA1UEAxMDREVWAggKIBYGKRgyATAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNTA2MjAyMTEwWjAjBgkqhkiG9w0BCQQxFgQU3oy1UHrM5K3%21cDp4vVYNgTlG0VgwCQYHKoZIzjgEAwQuMCwCFDvft3KcN18HvAn431M01y5wg%2fUuAhQKxqiB0HFxOrjVBuwMZa2GII9KDg%3d%3d; path=/; domain=.0.1.13;sap-usercontext=sap-language=en&sap-client=800; path=/;fly_cid=8433badd-451f-4a6e-954c-373a73fcf031; Expires=Sun, 01 May 2039 20:21:14 GMT; HttpOnly';

List<String> values = data.split(';(?!\\s)');

for(String v : values ) {
    System.debug(v);
}