Write-Host "🚀 Starting CPQ Demo Deployment..." -ForegroundColor Green

# Check if connected to org
try {
    sfdx force:org:display | Out-Null
} catch {
    Write-Host "❌ Not connected to an org. Run: sfdx force:auth:web:login" -ForegroundColor Red
    exit 1
}

Write-Host "📦 Step 1: Deploying metadata (custom fields)..." -ForegroundColor Yellow
sfdx force:source:deploy -p force-app/main/default/objects

Write-Host "📊 Step 2: Creating Products and Options together..." -ForegroundColor Yellow
sfdx force:data:tree:import -p data/cpq-data-plan.json

Write-Host "⏳ Waiting for data to be available..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

Write-Host "💰 Step 3: Creating Price Book Entries..." -ForegroundColor Yellow
sfdx force:apex:execute -f scripts/apex/createPriceBookEntries.apex

Write-Host "✅ Deployment complete!" -ForegroundColor Green