#!/bin/bash

echo "Starting CPQ Demo Deployment..."

# Check if connected to org
if ! sfdx force:org:display &> /dev/null; then
    echo "ERR: Not connected to an org. Run: sfdx force:auth:web:login"
    exit 1
fi

echo "Step 1: Deploying metadata (custom fields)..."
sfdx force:source:deploy -p force-app/main/default/objects

echo "Step 2: Creating Products..."
sfdx force:data:tree:import -p data/products-plan.json

echo "Step 3: Creating Price Book Entries..."
sfdx force:apex:execute -f scripts/apex/createPriceBookEntries.apex

echo "Step 4: Creating Product Options (Bundle Configuration)..."
# Need to wait for products to be available
sleep 5
sfdx force:data:tree:import -f data/productOptions.json

echo "Step 5: Manual Configuration Required"
echo "================================"
echo "1. Configure Product Rules in CPQ:"
echo "   - Auto-include Priority Support at 200+ seats"
echo "   - Validate Analytics Pack requires 12+ month term"
echo "   - Alert for EU region GDPR compliance"
echo ""
echo "2. Configure Price Rules for tiered discounts"
echo ""
echo "3. Install QCP:"
echo "   - Copy contents from qcp/quoteCalculatorPlugin.js"
echo "   - Paste in Setup > Installed Packages > Salesforce CPQ > Quote Calculator Plugin"
echo ""
echo "See config/cpq-setup.md for detailed steps"