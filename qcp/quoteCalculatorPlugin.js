// Quote Calculator Plugin (QCP) minimum viable product example
export function onAfterCalculate(quote, lines, conn) {
  const seats = Number(quote.get("SBQQ__NumberOfSeats__c") || quote.get("Seats__c") || 0);
  const term  = Number(quote.get("SBQQ__SubscriptionTerm__c") || 12);
  const region= quote.get("Region__c") || "US";

  // annotate line descriptions
  lines.forEach(l => {
    const name = l.get("SBQQ__ProductName__c") || "";
    l.set("SBQQ__Description__c", `${name} — ${seats} seats • ${term} mo • ${region}`);
  });

  // set implementation Fee (~3% of net, min $1,000)
  const implCode = "IMPL-FEE";
  const netTotal = lines.reduce((sum, l) => sum + (Number(l.get("SBQQ__NetTotal__c")) || 0), 0);
  const fee = Math.max(1000, Math.round(netTotal * 0.03 * 100) / 100);

  let feeLine = lines.find(l => l.get("SBQQ__ProductCode__c") === implCode);
  if (!feeLine) {
    feeLine = quote.addLine({ ProductCode: implCode, SBQQ__Quantity__c: 1 });
  }
  feeLine.set("SBQQ__NetPrice__c", fee);
}
