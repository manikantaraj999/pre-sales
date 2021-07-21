@isTest public with sharing class TSTU_JWT {

@isTest
    public static void test_issues() {
        
        Test.startTest();
        JWT jwt1 = new JWT('HS256');

        jwt1.privateKey = 'test';
        jwt1.iss = 'test';
        jwt1.sub = 'test';
        jwt1.aud = 'test';
        jwt1.exp = 'test';
        jwt1.iat = 'test';
        jwt1.validFor = 1;
        jwt1.cert = null;
        jwt1.pkcs8 = 'test';
        jwt1.claims = new Map<String,String>();
        jwt1.claims.put('1','1');

        String result1 = jwt1.issue();
        jwt1.alg = 'RS256';
        try { jwt1.issue(); } catch (Exception e) {}
        jwt1.cert = 'test';
        try { jwt1.issue(); } catch (Exception e) {}
        jwt1.alg = 'none';
        try { jwt1.issue(); } catch (Exception e) {}
        Test.stopTest();

        System.Assert(result1 != null);

    }
@isTest
    public static void test_base64() {
        
        Test.startTest();
        Blob b = Blob.valueof('test');
        JWT jwt = new JWT('test');
        String result = jwt.base64URLencode(b);
        Test.stopTest();

        System.Assert(result != null);
    }

}