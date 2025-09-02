#!/bin/bash

echo "🚀 Loading CPQ Demo Data..."

# Check connection
if ! sfdx force:org:display &> /dev/null; then
    echo "❌ Not connected to an org. Run: sfdx force:auth:web:login"
    exit 1
fi

echo "📦 Step 1: Loading Products..."
sfdx force:data:tree:import -p data/products-plan.json

echo "⏳ Waiting for products to be available..."
sleep 5

echo "💰 Step 2: Creating Price Book Entries..."
sfdx force:apex:execute -f scripts/apex/createPriceBookEntries.apex

echo "⏳ Waiting for price book entries..."
sleep 3

echo "🔗 Step 3: Creating Product Options (Bundle Configuration)..."
sfdx force:data:tree:import -f data/productOptions.json

echo "✅ Data load complete!"
echo ""
echo "Next steps:"
echo "1. Run manual configuration from config/cpq-setup.md"
echo "2. Install QCP from qcp/quoteCalculatorPlugin.js"