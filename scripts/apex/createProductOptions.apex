// Get products
Product2 proSub = [SELECT Id FROM Product2 WHERE ProductCode = 'PRO-SUB' LIMIT 1];
Product2 prioSupport = [SELECT Id FROM Product2 WHERE ProductCode = 'SUP-PRIO' LIMIT 1];
Product2 analytics = [SELECT Id FROM Product2 WHERE ProductCode = 'ANL-PACK' LIMIT 1];

// Create Product Options
List<SBQQ__ProductOption__c> options = new List<SBQQ__ProductOption__c>{
    new SBQQ__ProductOption__c(
        SBQQ__Number__c = 10,
        SBQQ__ConfiguredSKU__c = proSub.Id,
        SBQQ__OptionalSKU__c = prioSupport.Id,
        SBQQ__Selected__c = false,
        SBQQ__Quantity__c = 1,
        SBQQ__Type__c = 'Component'
    ),
    new SBQQ__ProductOption__c(
        SBQQ__Number__c = 20,
        SBQQ__ConfiguredSKU__c = proSub.Id,
        SBQQ__OptionalSKU__c = analytics.Id,
        SBQQ__Selected__c = false,
        SBQQ__Quantity__c = 1,
        SBQQ__Type__c = 'Component'
    )
};

insert options;
System.debug('Created ' + options.size() + ' product options');