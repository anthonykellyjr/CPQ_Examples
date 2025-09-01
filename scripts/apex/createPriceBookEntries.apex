// Get Standard Price Book
Id stdPriceBookId = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1].Id;

// Get Products
Map<String, Product2> productMap = new Map<String, Product2>();
for(Product2 p : [SELECT Id, ProductCode FROM Product2 WHERE ProductCode IN ('PRO-SUB','SUP-PRIO','ANL-PACK','IMPL-FEE','REG-FEE')]) {
    productMap.put(p.ProductCode, p);
}

// Create Price Book Entries
List<PricebookEntry> entries = new List<PricebookEntry>{
    new PricebookEntry(
        Pricebook2Id = stdPriceBookId,
        Product2Id = productMap.get('PRO-SUB').Id,
        UnitPrice = 100,
        IsActive = true
    ),
    new PricebookEntry(
        Pricebook2Id = stdPriceBookId,
        Product2Id = productMap.get('SUP-PRIO').Id,
        UnitPrice = 20,
        IsActive = true
    ),
    new PricebookEntry(
        Pricebook2Id = stdPriceBookId,
        Product2Id = productMap.get('ANL-PACK').Id,
        UnitPrice = 50,
        IsActive = true
    ),
    new PricebookEntry(
        Pricebook2Id = stdPriceBookId,
        Product2Id = productMap.get('IMPL-FEE').Id,
        UnitPrice = 0,
        IsActive = true
    ),
    new PricebookEntry(
        Pricebook2Id = stdPriceBookId,
        Product2Id = productMap.get('REG-FEE').Id,
        UnitPrice = 0,
        IsActive = true
    )
};

insert entries;