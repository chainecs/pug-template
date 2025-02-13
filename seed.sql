INSERT
	INTO
	noti_engine.templates (name,
	description,
	subject,
	template,
	variables,
	channel,
	created_at,
	updated_at)
VALUES
(
  'POSTPAID_CYCLE_REPORT',
  'Send email with resource usage summary to project owner',
  'Cycle Report',
  'div(style="background-color: #f3f3ff;")
    div(style="max-width: 720px; width:80%; margin: auto; padding: 20px; background-color: #ffffff; font-family: Helvetica, Arial, sans-serif; font-size: 13px; color: #666666; ")
      table(style="width: 100%; border-collapse: collapse; margin-bottom: 20px;")
        tr
          td(align="center")
            img(
              src=logo || "https://space.nipa.cloud/assets/images/Logo-space.png" 
              alt="Nipa Cloud Logo" 
              title="Nipa Cloud Logo" 
              style="display:block; width: 150px;"
              width="150"
            )
      p Dear #{recipient_name || "[...]"},
      p
        | Attached is your 
        strong #{billing_period || "01/JAN/25 - 01/FEB/25"} Cycle Report
        | , which provides a summary of resource usage and associated costs for this cycle. Below is a summary of key details:

      h3(style="margin: 20px 0 10px; font-size: 18px; color: #333;") Resource Usage Summary
      p
        strong Period:
        | #{billing_period || "01/JAN/25 to 01/FEB/25"}
      p
        strong Project ID:
        | #{project_id || "IDW985W6-3W73-11WW-WW56-0242WW120002"}
      p(style="font-weight: bold; color: #888; border-bottom: 1px solid #ddd; padding-bottom: 5px; margin-top: 20px;") Resource Usage Summary Table
      table(style="width: 100%; border-collapse: collapse; margin-top: 10px;")
        thead
          tr(style="background-color: #f3f3ff; text-align: left;")
            th(style="padding: 10px; border-bottom: 2px solid #ddd;") Resource
            th(style="padding: 10px; border-bottom: 2px solid #ddd; text-align: right;") Price
        tbody
          each item in resources
            tr
              td(style="padding: 10px; border-bottom: 1px solid #ddd;")= item.name
              td(style="padding: 10px; border-bottom: 1px solid #ddd; text-align: right;")= item.price
          tr(style="font-weight: bold;")
            td(style="padding: 10px; border-top: 2px solid #ddd;") Total
            td(style="padding: 10px; border-top: 2px solid #ddd; text-align: right;") #{total_price || "000,000,000.000000 THB"}
          tr(style="font-weight: bold;")
            td(style="padding: 10px;") VAT 7%
            td(style="padding: 10px; text-align: right;") #{vat || "000,000,000.000000 THB"}
          tr(style="font-weight: bold; font-size: 16px;")
            td(style="padding: 10px;") Grand Total
            td(style="padding: 10px; text-align: right;") #{grand_total || "000,000,000.000000 THB"}

      p(style="margin-top: 20px;") For a complete breakdown, please refer to the attached report. If you have any questions, please contact us via 
        a(href=contact_url style="color: red;") Customer Support 
        span  or 
        span(style="font-weight: bold;")  082 6328 3030
        span  or 
        a(href=support_email style="color: red;") support@nipa.cloud
      p(style="margin-top: 20px;") Best regards,
      p(style="font-weight: bold;") Nipa Cloud Team
      hr(style="border: 0; border-top: 1px solid #ddd; margin-top: 10px; margin-bottom: 10px;")
      p(style="font-size: 12px; color: #888; margin-bottom: 5px; line-height: 18px;") NIPA Cloud does not request any personal information, such as a username or password. If you are contacted and asked for such information, please do not provide it and inform the NIPA Cloud team for your safety.
      p(style="font-size: 12px; color: #888; font-weight: bold;") This is an automated email. No reply is required.',
    '{
      "name": "RESOURCE_USAGE_SUMMARY",
      "properties": {
        "logo": [],
        "recipient_name": [],
        "billing_period": [],
        "project_id": [],
        "resources": [],
        "total_price": [],
        "vat": [],
        "grand_total": [],
        "contact_url": [],
        "support_email": []
      }
    }',
    'email',
    '2025-02-13 10:00:00',
    '2025-02-13 10:00:00'
);
