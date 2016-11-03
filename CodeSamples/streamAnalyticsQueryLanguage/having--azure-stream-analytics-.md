---
title: "HAVING (Azure Stream Analytics)"
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
ms.assetid: a5f2e124-86a0-4163-a125-3a0c9e4cc615
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
# HAVING (Azure Stream Analytics)
  Specifies a search condition for a group or an aggregate. HAVING can be used only with the SELECT expression. HAVING is typically used in a GROUP BY clause. When GROUP BY is not used, HAVING behaves like a WHERE clause.  
  
 **Syntax**  
  
```  
[ HAVING <search condition> ]  
```  
  
## Arguments  
 **<search_condition>**  
  
 Specifies the search condition for the group or the aggregate to meet.  
  
## Example  
  
```  
SELECT TollId, System.Timestamp AS WinEndTime, COUNT(*)   
FROM TollTagEntry TIMESTAMP BY EntryTime  
GROUP BY TumblingWindow( minute , 3 ) , TollId  
HAVING COUNT(*) > 2  
  
```  
  
  