---
title: "JOIN (Azure Stream Analytics)"
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
ms.assetid: 6cb2e1d5-899f-490b-b2fd-4878f53cefea
caps.latest.revision: 14
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
# JOIN (Azure Stream Analytics)
  Like standard T-SQL, JOIN in the Azure Stream Analytics query language are used to combine records from two or more input sources.  JOIN in Azure Stream Analytics are temporal in nature, meaning that each JOIN must provide some limits on how far the matching rows can be separated in time.  For instance, saying “join TollBoothEntry events with TollBoothExit events when they occur on the same LicensePlate and TollId and within 5 minutes of each other” is legitimate; but “join TollBoothEntry events with TollBoothExit events when they occur on the LicensePlate and TollId” is not – it would match each TollBoothEntry with an unbounded and potentially infinite collection of all TollBoothExit to the same LicensePlate and TollId.  
  
 The time bounds for the relationship are specified inside the ON clause of the JOIN, using the DATEDIFF function.  For more details on its general use, see [DATEDIFF &#40;Azure Stream Analytics&#41;](../streamAnalyticsQueryLanguage/datediff--azure-stream-analytics-.md). When DATEDIFF is used inside the JOIN condition, the second and third parameter gain special treatment.  
  
 **Syntax**  
  
```  
[ FROM { <input_source> } [ ,...n ] ]  
<input_source> ::=   
{  
    input_name [ [ AS ] input_alias ]   
    | <joined_table>   
}  
  
<joined_table> ::=   
{  
    <input_source> <join_type> <input_source> ON <join_condition>   
    | [ <input_source> <join_type> <reference_data> ON <join_condition> ]  
    | [ ( ] <joined_table> [ ) ]   
}  
<join_type> ::=   
    [ { INNER | LEFT [ OUTER ] } ] JOIN  
  
```  
  
## Arguments  
 **<input_source>**  
  
 Specifies the input data source.  
  
 **<reference_data>**  
  
 The reference data to which you want to Join your input_source. For more information, see Reference Data Join section.  
  
 **<join_type>**  
  
 Specifies the type of join operation.  
  
 **JOIN**  
  
 Indicates that the specified join operation should occur between the specified input sources and /or reference data. All rows from the left and right meeting the join condition are included in the result set.  
  
> [!WARNING]  
>  NOTE:If JOIN sources are partitioned, the JOIN predicate must include a condition matching the partition keys of both sources.  
  
 **[ LEFT  OUTER JOIN ]**  
  
 Specifies that all rows from the left table not meeting the join condition are included in the result set, and output columns from the other table are set to NULL in addition to all rows returned by the inner join.  
  
 **ON <join_condition>**  
  
 Specifies the condition on which the join is based. The join condition must have a time bound or a temporal wiggle room defined for the relationship and is specified inside the ON clause of the JOIN, using the special syntax of [Special DATEDIFF Function for JOIN](../streamAnalyticsQueryLanguage/join--azure-stream-analytics-.md#BKMK_DateDiff)function.  
  
## Examples  
 In Azure Stream Analytics, all events have a well-defined timestamp.  Thus, the user must use row aliases directly in the DATEDIFF function, as follows:  
  
```  
SELECT I1.TollId, I1.EntryTime,I2.ExitTime, I1.LicensePlate, DATEDIFF(minute,I1.EntryTime,I2.ExitTime) AS DurationInMinutes   
FROM Input1 I1 TIMESTAMP BY EntryTime   
JOIN Input2 I2 TIMESTAMP BY ExitTime  
ON DATEDIFF(minute,I1,I2) BETWEEN 0 AND 15  
  
```  
  
 The join condition above will result in a match if and only if the ExitTime occurs after the EntryTime, but no more than 15 minutes later.  
  
> [!NOTE]  
>  DATEDIFF used in the SELECT statement uses the general syntax where we pass a datetime column or expression as the second and third parameter. But when we use the DATEDIFF function inside the JOIN condition, we pass the input_source name or its alias. Internally the timestamp associated for each event in that source is picked.  
  
> [!NOTE]  
>  You cannot use SELECT * in JOIN.  
  
 Time bound conditions can be combined with each other and with other conditions inside the ON clause, e.g.:  
  
```  
SELECT I1.TollId, I1.EntryTime, I2.ExitTime, I1.LicensePlate, DATEDIFF(minute,I1.EntryTime,I2.ExitTime) AS DurationinMinutes   
FROM Input1 I1 TIMESTAMP BY EntryTime   
JOIN Input2 I2 TIMESTAMP BY ExitTime  
ON I1.TollId=I2.TollId  
AND I1.LicensePlate=I2.LicensePlate  
AND DATEDIFF(minute,I1,I2) BETWEEN 0 AND 15  
  
```  
  
 When joining 3 or more tables, the same rules apply --- time bounds must ensure that all matched events occur within a finite amount of time from each other.  For instance, to find all errors that occurred between transaction start and transaction end event, one can say:  
  
```  
SELECT TS.Id, TS.Name, TS.Amount, E.ErrorCode, E.Description   
FROM TStart TS TIMESTAMP BY TStartTime   
JOIN TEnd TE TIMESTAMP BY TEndTime  
ON DATEDIFF(second, TS, TE) BETWEEEN 0 AND 5  
AND TS.Id = TE.Id  
JOIN Error E TIMESTAMP BY ErrorTime  
ON DATEDIFF(second, TS, E) BETWEEN 0 AND 5  
AND E.TId = TS.Id  
  
```  
  
 When joining sources that are partitioned, the JOIN predicate must include a condition matching the partition keys of both sources.  
  
```  
EXAMPLE:  
  
SELECT I1.TollId, I1.EntryTime,I2.ExitTime, I1.LicensePlate, DATEDIFF(minute,I1.EntryTime,I2.ExitTime) AS DurationInMinutes   
FROM Input1 I1 TIMESTAMP BY EntryTime PARTITION BY PartitionId  
JOIN Input2 I2 TIMESTAMP BY ExitTime PARTITION BY PartitionId  
ON I1.PartitionId = I2.PartitionId AND DATEDIFF(minute,I1,I2) BETWEEN 0 AND 15  
```  
  
 Finally, Azure Stream Analytics supports both inner join (the default) and LEFT outer join.  For an inner join, a result is only returned when a match is found.  But for a LEFT OUTER join, if an event from the left side of the join is unmatched, a row with NULL for all the columns of the right row is returned.  For instance here is an example to find the absence of events. The following query will return those rows where a Vehicle has entered a Toll Booth but have not exited the Booth within 15 minutes.  
  
```  
SELECT I1.TollId, I1.EntryTime, I2.ExitTime, I1.LicensePlate, DATEDIFF(minute,I1.EntryTime,I2.ExitTime) AS DurationinMinutes   
FROM Input1 I1 TIMESTAMP BY EntryTime   
LEFT OUTER JOIN Input2 I2 TIMESTAMP BY ExitTime  
ON I1.TollId=I2.TollId  
AND I1.LicensePlate=I2.LicensePlate  
AND DATEDIFF( minute , I1 , I2 ) BETWEEN 0 AND 15   
WHERE I2.TollId IS NULL  
  
```  
  
##  <a name="BKMK_DateDiff"></a> Special DATEDIFF Function for JOIN  
 **Syntax**  
  
```  
DATEDIFF ( datepart , input_source1, input_source2 )  
```  
  
### Arguments  
 **dateparts**  
  
 Example. ‘second’, ‘millisecond’, ‘minute’, etc)  
  
 **input_source1**  
  
 The first input source in the Join. Internally the timestamp associated with the events from this input_source is passed into the function.  
  
 **input_source2**  
  
 The second input source in the Join. Internally the timestamp associated with the events from this input_source is passed into the function.  
  
### Return Type  
 Returns the number of units in dateparts that elapsed from the timestamp of input_source1 to the timestamp of input_source2. Note that the returned value can be negative if the timestamp of second input_source is greater than the first.  
  
 The maximum size of the window in all cases is 7 days.  
  
  