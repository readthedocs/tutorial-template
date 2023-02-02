---
title: "Architecture"
description: ""
lead: ""
date: 2022-10-26T12:43:56+02:00
lastmod: 2022-10-26T12:43:56+02:00
draft: false
images: []
menu:
  docs:
    parent: ""
    identifier: "architecture-753221c1ba6925cd19e66e7a9fccfe7d"
weight: 8
toc: true
mermaid: true
---

{{< mermaid class="bg-light text-center" >}}
graph TB

subgraph Site
AS[Acquisition Service] -- Configuration --> SDB[(Site DB)]
P[IoT Probe] -- Ethernet --> AS
R[Reader] -- LLRP --> AS
BLEGW[BLE Gateway]
end

subgraph Cloud
T[Traxsense] -- SQL --> TDB[(Traxsense DB)]
E[Eventbridge] -- SQL --> TDB
end

AS -- MQTT --> E
BLEGW -- MQTT --> E
U{{User}} --> M[Mobile]
U --> B[Browser]
B --> T
M --> T
{{< /mermaid >}}
