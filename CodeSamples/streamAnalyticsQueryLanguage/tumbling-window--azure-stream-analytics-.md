---
title: "Tumbling Window (Azure Stream Analytics)"
ms.custom: na
ms.date: "2016-04-22"
ms.prod: "azure"
ms.reviewer: na
ms.service: "stream-analytics"
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: "reference"
applies_to: 
  - "Azure"
ms.assetid: cfc2fb3b-0e8e-4b5e-b3ba-8ca6fea61c17
caps.latest.revision: 12
ms.author: "jeffstok"
manager: "jhubbard"
translation.priority.mt: 
  - "de-de"
  - "es-es"
  - "fr-fr"
  - "it-it"
  - "ja-jp"
  - "ko-kr"
  - "pt-br"
  - "ru-ru"
  - "zh-cn"
  - "zh-tw"
---
# Tumbling Window (Azure Stream Analytics)
  Tumbling windows are a series of fixed-sized, non-overlapping and contiguous time intervals. The following diagram illustrates a stream with a series of events and how they are mapped into 5-second tumbling windows.  
  
 ![Stream Analytics tumbling window 5 mins](../streamAnalyticsQueryLanguage/media/streamanalytics-tumblingwindow5mins.png "StreamAnalytics-TumblingWindow5mins")  
  
 **Syntax**  
  
```  
TUMBLINGWINDOW ( timeunit  , windowsize, [offsetsize] )  
TUMBLINGWINDOW ( Duration( timeunit  , windowsize ), [Offset(timeunit  , offsetsize)] )  
  
```  
  
> [!NOTE]  
>  The Tumbling Window can be used in the above two ways. To allow consistency with the Hopping Window, the Duration function can also be used with all types of windows to specify the window size.  
  
## Arguments  
 **timeunit**  
  
 Is the unit of time for the windowsize. The following table lists all valid timeunit arguments.  
  
|Timeunit|Abbreviations|  
|--------------|-------------------|  
|day|dd, d|  
|hour|hh|  
|minute|mi, n|  
|second|ss, s|  
|millisecond|ms|  
|microsecond|mcs|  
  
 **windowsize**  
  
 A big integer which describes the size of the window.  
  
 The maximum size of the window is 7 days.  
  
 **offsetsize**  
  
 By default, tumbling windows are inclusive in the end of the window and exclusive in the beginning – for example 12:00 PM – 1:00 PM window will include events that happened exactly at 1:00 PM, but will not include events that happened at 12:00PM (these events will be part of 11:00 AM – 12:00 PM window).  
  
 The Offset parameter can be used to change this behavior and include the events in the beginning of the window and exclude the ones that happened in the end.  
  
## Examples  
  
```  
SELECT System.TimeStamp AS WindowEnd, TollId, COUNT(*)  
FROM Input TIMESTAMP BY EntryTime  
GROUP BY TollId, TumblingWindow(Duration(hour, 1), Offset(millisecond, -1))  
  
```  
  
## See Also  
 [Hopping Window](../streamAnalyticsQueryLanguage/hopping-window--azure-stream-analytics-.md)   
 [Sliding Window](../streamAnalyticsQueryLanguage/sliding-window--azure-stream-analytics-.md)   
 [Windowing](../streamAnalyticsQueryLanguage/windowing--azure-stream-analytics-.md)  
  
  