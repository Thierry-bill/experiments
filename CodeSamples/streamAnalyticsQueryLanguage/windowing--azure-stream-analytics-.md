---
title: "Windowing (Azure Stream Analytics)"
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
ms.assetid: 5b46b0df-c441-4729-be82-9c000130fdbb
caps.latest.revision: 11
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
# Windowing (Azure Stream Analytics)
  In applications that process real-time events, a common requirement is to perform some set-based computation (aggregation) or other operations over subsets of events that fall within some period of time. Because the concept of time is a fundamental necessity to complex event-processing systems, it’s important to have a simple way to work with the time component of query logic in the system. In Azure Stream Analytics, these subsets of events are defined through windows to represent groupings by time. This topic describes windows and how they are defined, identifies the types of windows that are supported, and explains how you can use windows with various operators.  
  
## Understanding Windows  
 A window contains event data along a timeline and enables you to perform various operations against the events within that window. For example, you may want to sum the values of payload fields in a given window as shown in the following illustration.  
  
 ![Stream Analytics query language tumbling window](../streamAnalyticsQueryLanguage/media/streamanalytics-tumblingwindow.png "StreamAnalytics-TumblingWindow")  
  
 Every window operation outputs event at the end of the window. The windows of Azure Stream Analytics are opened at the window start time and closed at the window end time. For example, if you have a 5 minute window from 12:00 AM to 12:05 AM all events with timestamp greater than 12:00 AM  and up to timestamp 12:05 AM inclusive will be included within this window. The output of the window will be a single event based on the aggregate function used with a timestamp equal to the window end time.  The timestamp of the output event of the window can be projected in the SELECT statement using the System.Timestamp property using an alias. Every window automatically aligns itself to the zeroth hour. For example, a 5 minute tumbling window will align itself to (12:00-12:05] , (12:05-12:10], …  
  
> [!NOTE]  
>  All windows should be used in a GROUP BY clause.  
  
 There are 3 types of windows:  
  
1.  [Tumbling Window &#40;Azure Stream Analytics&#41;](../streamAnalyticsQueryLanguage/tumbling-window--azure-stream-analytics-.md)  
  
2.  [Hopping Window &#40;Azure Stream Analytics&#41;](../streamAnalyticsQueryLanguage/hopping-window--azure-stream-analytics-.md)  
  
3.  [Sliding Window &#40;Azure Stream Analytics&#41;](../streamAnalyticsQueryLanguage/sliding-window--azure-stream-analytics-.md)  
  
 The maximum size of the window in all cases is 7 days.  
  
  