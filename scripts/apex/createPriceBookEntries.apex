// Get Standard Price Book
Id stdPriceBookId = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1].Id;

// Get Products - check if they exist first
List<Product2> products = [
    SELECT Id, ProductCode 
    FROM Product2 
    WHERE ProductCode IN ('PRO-SUB','SUP-PRIO','ANL-PACK','IMPL-FEE','REG-FEE')
];

if(products.isEmpty()) {
    System.debug('No products found. Make sure products are created first.');
    return;
}

// Create map for easy lookup
Map<String, Id> productMap = new Map<String, Id>();
for(Product2 p : products) {
    productMap.put(p.ProductCode, p.Id);
}

// Create Price Book Entries
List<PricebookEntry> entries = new List<PricebookEntry>();

if(productMap.containsKey('PRO-SUB')) {
    entries.add(new PricebookEntry(
        Pricebook2Id = stdPriceBookId,
        Product2Id = productMap.get('PRO-SUB'),
        UnitPrice = 100.00,
        IsActive = true
    ));
}

if(productMap.containsKey('SUP-PRIO')) {
    entries.add(new PricebookEntry(
        Pricebook2Id = stdPriceBookId,
        Product2Id = productMap.get('SUP-PRIO'),
        UnitPrice = 20.00,
        IsActive = true
    ));
}

if(productMap.containsKey('ANL-PACK')) {
    entries.add(new PricebookEntry(
        Pricebook2Id = stdPriceBookId,
        Product2Id = productMap.get('ANL-PACK'),
        UnitPrice = 50.00,
        IsActive = true
    ));
}

if(productMap.containsKey('IMPL-FEE')) {
    entries.add(new PricebookEntry(
        Pricebook2Id = stdPriceBookId,
        Product2Id = productMap.get('IMPL-FEE'),
        UnitPrice = 0.00,
        IsActive = true
    ));
}

if(productMap.containsKey('REG-FEE')) {
    entries.add(new PricebookEntry(
        Pricebook2Id = stdPriceBookId,
        Product2Id = productMap.get('REG-FEE'),
        UnitPrice = 0.00,
        IsActive = true
    ));
}

if(!entries.isEmpty()) {
    insert entries;
    System.debug('Created ' + entries.size() + ' price book entries.');
}