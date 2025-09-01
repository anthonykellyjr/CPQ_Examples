Based on the text you provided, here is a cleaned-up, professional version of the test case scenarios and troubleshooting guide.

### CPQ Test Cases

#### Scenario 1: Basic Configuration
**Objective**: Confirm the fundamental product selection and pricing functionality.
* **Steps**:
    1.  Create a new opportunity and quote for a test account.
    2.  Set the quote's **Region** to "US" and **Subscription Term** to 12.
    3.  Navigate to **Edit Lines** and add "Pro Subscription" with a **Quantity** of 75.
    4.  Within the configurator, confirm "Priority Support" and "Analytics Pack" appear as options and are unchecked.
    5.  Manually select "Analytics Pack."
    6.  Save the configuration.
* **Expected Results**:
    * The quote displays "Pro Subscription" with a total price of $7,500 ($100 x 75) and a 0% discount.
    * "Analytics Pack" is included as a selected product.
    * An "Implementation Fee" line item, approximately $225, is added.

---

#### Scenario 2: Discount Tier Validation
**Objective**: Verify the three configured discount tiers function as designed.
* **Steps**:
    * Test a quote with a quantity of **99 seats**; a 0% discount is expected.
    * Test a quote with a quantity of **100 seats**; a 5% discount is expected.
    * Test a quote with a quantity of **200 seats**; a 12% discount is expected, and "Priority Support" should be automatically selected.

---

#### Scenario 3: Business Rule Validation
**Objective**: Confirm all product rules trigger correctly.
* **Steps**:
    * **Selection Rule**: With a quantity of 200 or greater, confirm that "Priority Support" is automatically selected.
    * **Validation Rule**: With the quote's "Subscription Term" set to 6 months, attempting to select "Analytics Pack" should produce a validation error.
    * **Alert Rule**: With the quote's **Region** set to "EU," an alert message about GDPR compliance should be displayed.

---

#### Scenario 4: Quote Calculator Plugin (QCP) Validation
**Objective**: Confirm the custom QCP functionality is operational.
* **Steps**:
    * Verify an "Implementation Fee" line is added to the quote, calculated as 3% of the net total with a minimum of $1,000.
    * Verify the line descriptions are updated with the seat quantity, term, and region information.
    * Confirm the fee calculation is correct for large deals.

---

### Common Issues and Resolutions

* **"No products found"**:
    * Ensure the products are **active**.
    * Confirm **price book entries** exist for the products.
    * Verify the user has the required **CPQ permissions**.
* **Options not visible in the configurator**:
    * Confirm that **Product Options** have been created.
    * Check that the bundle product's **Configuration Type** is set to "Allowed."
* **Discounts are not applied**:
    * Manually click the **"Calculate" button** on the quote.
    * Verify the **Price Rule conditions** are correct.
    * Confirm that the `SBQQ__ProductCode__c` field value matches exactly.
* **QCP does not add fees**:
    * Confirm the plugin is **Activated**, not just saved.
    * Verify the "IMPL-FEE" product code exists.
    * Check the browser's console for JavaScript errors.