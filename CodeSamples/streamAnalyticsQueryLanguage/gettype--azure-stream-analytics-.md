---
title: "GetType (Azure Stream Analytics)"
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
ms.assetid: 94c6d620-c00f-4246-86b3-cd4e2c040a61
caps.latest.revision: 4
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
# GetType (Azure Stream Analytics)
  Returns a data type name of the value.  
  
 **Syntax**  
  
```  
GetType (expression)  
  
```  
  
## Arguments  
 **expression**  
  
 Is any valid expression.  
  
## Return Types  
 Returns a data type name for the expression. Please see all supported data types in [Data Types &#40;Azure Stream Analytics&#41;](../streamAnalyticsQueryLanguage/data-types--azure-stream-analytics-.md).  
  
## Examples  
  
```  
SELECT TollId, EntryTime   
FROM Input  
WHERE GetType( EntryTime ) = ‘datetime’  
```  
  
  