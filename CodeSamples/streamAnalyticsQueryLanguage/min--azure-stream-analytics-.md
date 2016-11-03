---
title: "MIN (Azure Stream Analytics)"
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
ms.assetid: 0480d0eb-babe-4356-a5c0-93001b51744c
caps.latest.revision: 6
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
# MIN (Azure Stream Analytics)
  Returns the minimum value in the expression.  
  
 **Syntax**  
  
```  
MIN ( expression )  
```  
  
## Arguments  
 **expression**  
  
 Is a constant, column name, or function, and any combination of arithmetic operators. MIN can be used with bigint and float columns. Aggregate functions and subqueries are not permitted.  
  
## Return Types  
 Returns a value same as expression.  
  
## General Remarks  
 If payload schema was not defined with CREATE TABLE statement and type of the result expression is unknown at query compilation time, return value will have float type.  
  
## Examples  
  
```  
SELECT System.TimeStamp AS OutTime, TollId, MIN (Toll)   
FROM Input TIMESTAMP BY EntryTime  
GROUP BY TollId, TumblingWindow(minute,3)  
  
```  
  
  