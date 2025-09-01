#!/bin/bash
echo "Deploying metadata..."
sfdx force:source:push

echo "Loading data..."
./scripts/loadData.sh

echo "Manual steps required:"
echo "1. Copy QCP code from force-app/main/default/qcp/QuoteCalculatorPlugin.js"
echo "2. Configure Product Rules as documented in config/cpq-setup.md"
echo "3. Configure Price Rules as documented in config/cpq-setup.md"