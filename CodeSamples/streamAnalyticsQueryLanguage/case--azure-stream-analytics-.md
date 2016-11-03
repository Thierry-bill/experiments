---
title: "CASE (Azure Stream Analytics)"
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
ms.assetid: 7c32501d-0e3e-49e8-8c84-61d33830e355
caps.latest.revision: 7
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
# CASE (Azure Stream Analytics)
  Evaluates a list of conditions and returns one of multiple possible result expressions.  
  
 The CASE expression has two formats:  
  
-   The simple CASE expression compares an expression to a set of simple expressions to determine the result.  
  
-   The searched CASE expression evaluates a set of Boolean expressions to determine the result.  
  
 Both formats require an ELSE argument.  
  
 CASE can be used in any statement or clause that allows a valid expression. For example, you can use CASE in expressions such as SELECT and in clauses such as WHERE and HAVING.  
  
 **Syntax**  
  
 Simple CASE expression:  
  
```  
CASE input_expression   
     WHEN when_expression THEN result_expression [ ...n ]   
     ELSE else_result_expression   
END  
  
```  
  
 Searched CASE expression:  
  
```  
CASE  
     WHEN Boolean_expression THEN result_expression [ ...n ]   
     ELSE else_result_expression  
END  
  
```  
  
  