## CPQ Configuration Guide

This guide details the manual configuration required after deployment.

---

### Create Summary Variables

Create two summary variables to reference quote-level fields.

#### Variable 1: QuoteTerm
* **Variable Name**: `QuoteTerm`
* **Target Object**: Quote
* **Aggregate Function**: Value
* **Aggregate Field**: `SBQQ__SubscriptionTerm__c`

#### Variable 2: QuoteRegion
* **Variable Name**: `QuoteRegion`
* **Target Object**: Quote
* **Aggregate Function**: Value
* **Aggregate Field**: `Region__c`

---

### Create Product Rules

Create three product rules to manage product selection, validation, and alerts.

#### Rule A: Auto-Include Priority Support
* **Type**: Selection
* **Scope**: Product
* **Evaluation Event**: Always
* **Conditions**:
    * **Tested Field**: `SBQQ__BundledQuantity__c`
    * **Operator**: greater or equal
    * **Filter Value**: 200
* **Actions**:
    * **Type**: Select
    * **Product**: Pro Subscription
    * **Product Option**: Priority Support

#### Rule B: Analytics Pack Term Validation
* **Type**: Validation
* **Scope**: Product
* **Evaluation Event**: Always
* **Conditions**:
    * **Tested Variable**: QuoteTerm, Operator `less than`, Value 12
    * **Tested Field**: `SBQQ__ProductCode__c`, Operator `equals`, Value `ANL-PACK`
    * **Tested Field**: `SBQQ__Selected__c`, Operator `equals`, Value `TRUE`
* **Message**: `Analytics Pack requires a subscription term of at least 12 months.`

#### Rule C: EU GDPR Alert
* **Type**: Alert
* **Scope**: Quote
* **Evaluation Event**: Always
* **Conditions**:
    * **Tested Variable**: QuoteRegion
    * **Operator**: equals
    * **Filter Value**: `EU`
* **Message**: `GDPR Notice: This quote is for an EU customer. Please ensure all GDPR compliance requirements are met and documented.`

---

### Create Price Rules

Create three price rules for discount tiers based on quantity.

#### Price Rule 1: Base Tier (0% discount)
* **Evaluation Scope**: Calculator
* **Conditions**:
    * `SBQQ__ProductCode__c` equals `PRO-SUB`
    * `SBQQ__Quantity__c` less or equal 99
* **Actions**:
    * Set `SBQQ__Discount__c` to 0.

#### Price Rule 2: Mid Tier (5% discount)
* **Evaluation Scope**: Calculator
* **Conditions**:
    * `SBQQ__ProductCode__c` equals `PRO-SUB`
    * `SBQQ__Quantity__c` greater or equal 100
    * `SBQQ__Quantity__c` less or equal 199
* **Actions**:
    * Set `SBQQ__Discount__c` to 5.

#### Price Rule 3: High Tier (12% discount)
* **Evaluation Scope**: Calculator
* **Conditions**:
    * `SBQQ__ProductCode__c` equals `PRO-SUB`
    * `SBQQ__Quantity__c` greater or equal 200
* **Actions**:
    * Set `SBQQ__Discount__c` to 12.

---

### Install Quote Calculator Plugin (QCP)

1. Navigate to **Installed Packages**, then **Salesforce CPQ**.
2. Go to the **Pricing and Calculation** tab.
3. Access the **Quote Calculator Plugin**.
4. Paste the JavaScript code into the editor.
5. Click **Save** and then **Activate**.

---

### Configuration Validation

* **Test Case 1 (50 seats)**: A quote with 50 seats should have a 0% discount and no auto-selected options.
* **Test Case 2 (150 seats)**: A quote with 150 seats for the EU region should have a 5% discount and display the GDPR alert.
* **Test Case 3 (250 seats)**: A quote with 250 seats should have a 12% discount, auto-select "Priority Support," and add the "Implementation Fee" line via QCP.
* **Test Case 4 (Validation)**: A quote with a 6-month term should prevent the selection of "Analytics Pack" and display a validation error.

---

### Troubleshooting

* **Product Rules:** Ensure the rule is **Active**, the **Evaluation Event** is "Always," and **Conditions Met** is "All." Verify summary variables are correctly configured.
* **Price Rules:** Confirm the **Calculator Evaluation Event** is "On Calculate," and the conditions reference the correct fields. Click "Calculate" on the quote to trigger the rules.
* **QCP:** Verify the plugin is both **Saved** and **Activated**. Check the browser console for JavaScript errors.
* **Product Options:** Ensure they have been successfully created, and the `Configuration Type` for the bundle is set to "Allowed."
* **Missing Products:** Confirm products are active, and price book entries exist for the user.