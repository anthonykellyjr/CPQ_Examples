# CPQ Demo — Click Path

1) Enable **Advanced Calculator** in Salesforce CPQ settings.
2) Create Product **Pro Subscription** (bundle).
3) Add bundle **Options**: Priority Support, Analytics Pack, Implementation Services.
4) Add Product Rules:
   - Selection: Seats ≥ 200 → Auto-include Priority Support
   - Validation: If Analytics Pack selected → Term ≥ 12
   - Alert: Region = EU → show GDPR advisory
5) Price Rules (Advanced Calculator):
   - Volume discount by Seats tiers
   - Region surcharge via Lookup Query for APAC
6) QCP:
   - Annotate line descriptions with “{seats} seats • {term} mo • {region}”
   - Inject/update an “Implementation Fee” line (~3% of net, min $1,000)
7) Test:
   - New Quote → Configure → vary Seats/Term/Region → Calculate → verify results
