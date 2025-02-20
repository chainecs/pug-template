INSERT INTO noti_engine.templates (
  name,
  description,
  subject,
  template,
  variables,
  channel,
  created_at,
  updated_at
)
VALUES
(
  'WALLET_CYCLE_USAGE_REPORT',
  'Send email with resource usage summary to project owner',
  'Cycle Report','
  div(style="background-color: #f3f3ff; padding: 16px 0;")
    div(style="max-width: 595px; display: flex; justify-content: center; align-items: center; margin: 0 auto;")
      div
        div(style="padding: 32px 24px; display: flex; flex-direction: column; background-color: #ffffff; font-family: Helvetica, Arial, sans-serif; font-size: 14px; color: #2A2C37; gap: 24px;")
          div
            img(src=logo alt="Nipa Cloud Logo"  title="Nipa Cloud Logo"  style="display:block; width: 150px;" width="150")
          div Dear #{recipient_name || "Customer"},
          div
            | Attached is your 
            strong #{cycle_started_at} - #{cycle_end_at} Cycle Report
            | , which provides the cost associated with your resource usage for this cycle.
          div Below is a summary of your resource usage and the total cost for this cycle.
          div(style="display: flex; flex-direction: column; padding: 0 16px;")
            div(style="display: flex; flex-direction: column; gap: 8px; margin-bottom: 16px;")
              div(style="font-weight:600; font-size: 16px;") Resource Usage Summary
              div(style="display: flex; flex-direction: row; align-items:center")
                div(style="width: 100px;")
                  strong Period
                div 
                | : #{cycle_started_at} to #{cycle_end_at}
              div(style="display: flex; flex-direction: row; align-items:center")
                div(style="width: 100px;")
                  strong Project ID
                div 
                | : #{project_id}
              div(style="display: flex; flex-direction: row; align-items:center")
                div(style="width: 100px;")
                  strong Project Name
                div 
                | : #{project_name}
            div    
              table(style="width: 100%; border-collapse: collapse; ")
                thead
                  tr(style="text-align: left; border-top: 1px solid #C5C7D3; border-bottom: 1px solid #E6E6EC; color:#8D91A6;")
                    th(style="padding: 8px 0;") Resource Type
                    th(style="padding: 8px 0; text-align: right;") Cost
                tbody
                  - var resourceList = resources || []
                  if !resourceList || resourceList.length === 0
                    - resourceList = []
                    - resourceList.push({ name: "Compute Instance", price: 0 })
                    - resourceList.push({ name: "Volumes", price: 0 })
                    - resourceList.push({ name: "Snapshots", price: 0 })
                    - resourceList.push({ name: "External IPs", price: 0 })
                    - resourceList.push({ name: "Load Balancers", price: 0 })
                    - resourceList.push({ name: "Database Instance", price: 0 })
                    - resourceList.push({ name: "Object Storage", price: 0 })
                    - resourceList.push({ name: "International Bandwidth", price: 0 })

                  each item in resourceList
                    tr(style="border-bottom: 1px solid #ddd;")
                    td(style="padding: 8px 0;")= item.name
                    td(style="padding: 8px 0; text-align: right;") #{((item.price) / 1000000).toLocaleString(undefined, {minimumFractionDigits: 6, maximumFractionDigits: 6})} THB

                  tr
                    td(style="padding: 8px 0;") Total
                    td(style="padding: 8px 0; text-align: right;") #{(total_amount / 1000000).toLocaleString(undefined, {minimumFractionDigits: 6, maximumFractionDigits: 6})} THB

                  tr
                    td(style="padding: 8px 0;") VAT 7%
                    td(style="padding: 8px 0; text-align: right;") #{(vat / 1000000).toLocaleString(undefined, {minimumFractionDigits: 6, maximumFractionDigits: 6})} THB

                  tr(style="border-bottom: 1px solid #C5C7D3; font-weight: bold;")
                    td(style="padding: 8px 0;") Grand Total
                    td(style="padding: 8px 0; text-align: right;") #{(grand_total / 1000000).toLocaleString(undefined, {minimumFractionDigits: 6, maximumFractionDigits: 6})} THB

          div For a complete breakdown, please refer to the attached report. For any questions or require further clarification, please feel free to contact us via 
            a(href=`#` style="font-weight: bold; color: #4959D1; text-decoration: none;") Customer Support 
            span  or 
            span(style="font-weight: bold;") +66 86 328 3030
            span  or 
            a(href=`#` style="font-weight: bold; color: #4959D1; text-decoration: none;") support@nipa.cloud
          div This report is based on Nipa Cloud’s Pay-as-you-go pricing model. Customers are charged based on actual usage, which may vary each cycle as shown in this report.
          div 
            div Best regards,
            div(style="color : #232C65;") Nipa Cloud Space Team
          div(style="border-bottom: 1px solid #C5C7D3;")
          div(style="align-self: center; color: #8D91A6; font-weight: 600; font-size: 10px;") Please do not reply, as this email was generated by an automated system.
        div(style='font-family: Helvetica, Arial, sans-serif; background-color: #1E2657; display: flex; flex-direction: column; text-align: center; padding: 16px 24px; gap: 16px ;font-size: 10px; color: #F9F9FC;')
          div
            slot(style="color : #8D91A6") © 
            span 2025 Nipa Technology Co., Ltd., All Rights Reserved.
          div NIPA Cloud does not request any personal information, such as a username or password. If you are asked to provide such information, please decline and inform us for your safety.
          div Privacy Policy | Terms of Service',
  '{
    "name": "WALLET_CYCLE_USAGE_REPORT",
    "properties": {
      "logo": [],
      "recipient_name": [],
      "cycle_started_at": [],
      "cycle_end_at": [],
      "project_id": [],
      "project_name": [],
      "resources": [],
      "total_amount": []
    }
  }',
  'email',
  '2025-02-13 10:00:00',
  '2025-02-13 10:00:00'
);
