<a id="network">Network Sizing</a>
-----------------------------

What about the network?
----------------------------

Whether leveraging Cloud resources to run Production, Test and Development, or as a Backup target and Recovery site it is important to understand your bandwidth needs for initial backup seeding and for on-going day-to-day transfers. 
You will require ample network capacity to support daily data transfers within the required transfer window without impacting Production applications. This section will outline the tools and techniques available to assess your network needs.

How can you understand how much bandwidth you will need?
----------------------------

1) Reports from your backup software. 
  <br>a. In each of the partner specific pages in the Backup and Archive workload section, we will highlight the reports available to help assess your change rate.
2) Backup software independent assessment and reporting tools like:
  <br>a. [MiTrend](https://mitrend.com/)
  <br>b. [Aptare](https://www.veritas.com/insights/aptare-it-analytics)

How will I know how much headroom I have with my current Internet connection?
----------------------------

1) Are you an existing Azure ExpressRoute customer? View your [circuit usage](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-monitoring-metrics-alerts#circuits-metrics)
2) You can Contact your ISP. They should have reports to share with you illustrating your existing daily and monthly utilization.
3) There are several tools that can measure utilization by monitoring your network traffic at your router/switch level including:
  <br>a. [Solarwinds Bandwidth Analyzer Pack](https://www.solarwinds.com/network-bandwidth-analyzer-pack?CMP=ORG-BLG-DNS)
  <br>b. [Paessler PRTG](https://www.paessler.com/bandwidth_monitoring)
  <br>c. [Cisco Network Assistant](https://www.cisco.com/c/en/us/products/cloud-systems-management/network-assistant/index.html)
  <br>d. [WhatsUp Gold](https://www.whatsupgold.com/network-traffic-monitoring)
