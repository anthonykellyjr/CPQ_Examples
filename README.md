# Salesforce CPQ Demo Project

A small, self-contained CPQ demo showing:
- A bundle with option constraints
- Price Rules (tiered discounts + region surcharge via Lookup Query)
- A Quote Calculator Plugin (QCP) that injects an Implementation Fee line and annotates line descriptions

**How to run:** Spin up Salesforce *CPQ-enabled* org (Developer Edition recommended). Can use with or without scratch org. 
Click-path is in `docs/click-path.md`.

# Trailhead CPQ Sandbox Dev Org Signup - lasts 90 days
https://trailhead.salesforce.com/promo/orgs/cpqtrails

# Once you receive auth email, click through, then set as default org in VSCode
    # Use the URL contained within the confirmation email as the login endpoint. for example:
    sf org login web --instance-url https://personal415-dev-ed.develop.my.salesforce.com --alias cpq-dev --set-default

# Greater detail on setting up the Advanced Calculator Plugin
1. Added region custom field to SBQQ__Quote__c to track customer location for pricing, compliance, etc
2. Seed the org with 5 products and add them to standard Price Book (data/products-plan.json, scripts/apex/createPriceBookEntries). PAY SPECIAL ATTENTION TO REFERENCE ID; it's needed to link products as bundles/options.
    The createPriceBookEntries.apex script sets pricing for products *after* creation and adds to price book. 
3. Configure bundles with data/productOptions.json - create parent-child relationships for products.
    * using @ syntax helps refer to products created/seeded earlier. Now, Priority Support and Analytics Pack show up as checkboxes when setting up a Pro Subscription
4. Product Rules - obviously this requires manual setup, so config/cpq-setup.md helps document those steps in markdown file
5. Price Rules - same as product rules in terms of manual setup and documentation in cpq-setup.md. Tiered discount rules are simpler than real use cases, being based just on quantity
6. Quote Calculator Plugin - as a dev, this is my favorite part. We copy the JS into the CPQ settings, and every time a quote gets calculated, it:
    * Check's the quote's region + quantity
    * calculates fees as related to total value
    * add or update lines programatically (less point and click - woo hoo!!)

7. Deployment flow -- THE ORDER OF STEPS IS VERY IMPORTANT!
    a. deploy the objects to the org (or set up declaratively)
        `sfdx force:source:deploy -p force-app/main/default/objects`

    b. seed the org with products, which use fields created in step a
        `sfdx force:data:tree:import -p data/products.json`

    c. create prices for the products seeded in step b
        `sfdx force:apex:execute -f scripts/apex/createPriceBookEntries.apex`

    d. create options/bundles, which are based on products and prices
        `sfdx force:data:tree:import -f data/productOptions.json`