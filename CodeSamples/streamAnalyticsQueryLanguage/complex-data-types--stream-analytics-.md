---
title: "Complex Data Types (Stream Analytics)"
ms.custom: na
ms.date: "2016-05-24"
ms.prod: "azure"
ms.reviewer: na
ms.service: "stream-analytics"
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: "reference"
applies_to: 
  - "Azure"
ms.assetid: 8f092502-b698-4576-b271-d43c1f88accc
caps.latest.revision: 10
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
# Complex Data Types (Stream Analytics)
  Azure Stream Analytics supports processing events in CSV, JSON and Avro data formats.  
Both JSON and Avro may contain complex types such as nested objects (records) or arrays. Scenarios may contain  complex data types that jobs must run against. Generally they are categorized as Array data types and Record data types.  
  
## Array data types  
 Array data types are an ordered collection of values. Some typical operations on array values are detailed below. Note that these examples assume the  input events have “arrayField” property of array type.  
  
## Examples  
 Select array element at a specified index (selecting the first array element):  
  
```  
SELECT   
    GetArrayElement(arrayField, 0) AS firstElement  
FROM input  
```  
  
 Select array length:  
  
```  
SELECT   
    GetArrayLength(arrayField) AS arrayLength  
FROM input  
```  
  
 Select all array element as individual events ( the [APPLY &#40;Azure Stream Analytics&#41;](../streamAnalyticsQueryLanguage/apply--azure-stream-analytics-.md) operator together with the [GetArrayElements &#40;Azure Stream Analytics&#41;](../streamAnalyticsQueryLanguage/getarrayelements--azure-stream-analytics-.md) built-in function extract all array elements as individual events):  
  
```  
SELECT   
    arrayElement.ArrayIndex,  
    arrayElement.ArrayValue  
FROM input as event  
CROSS APPLY GetArrayElements(event.arrayField) AS arrayElement  
```  
  
## Record data types  
 Record data types are used to represent JSON and Avro arrays when corresponding formats are used in the input data streams. . All examples assume a sample sensor which is reading input events in JSON format. Here is example of a single event:  
  
```  
{  
    "DeviceId" : "12345",  
    "Location" : {"Lat": 47, "Long": 122 }  
  
    "SensorReadings" :  
    {  
        "Temperature" : 80,  
        "Humidity" : 70,  
        "CustomSensor01" : 5,  
        "CustomSensor02" : 99  
    }  
}  
```  
  
## Examples  
 Utilize dot notation to access nested fields. For example, this query selects the reported lat/long coordinates of the device:  
  
```  
SELECT  
    DeviceID,  
    Location.Latitude,  
    Location.Longitude  
FROM input  
```  
  
 Use the [GetRecordPropertyValue &#40;Azure Stream Analytics&#41;](../streamAnalyticsQueryLanguage/getrecordpropertyvalue--azure-stream-analytics-.md) function if the property name is unknown. For example, imagine a  sample data stream needs to be joined with reference data containing thresholds for each device sensor:  
  
```  
SELECT  
    input.DeviceID,  
    thresholds.SensorName  
FROM input  
JOIN thresholds  
ON  
    input.DeviceId = thresholds.DeviceId  
WHERE  
    GetRecordPropertyValue(input.SensorReading, thresholds.SensorName) > thresholds.Value  
```  
  
 To convert record fields into separate events use the [APPLY &#40;Azure Stream Analytics&#41;](../streamAnalyticsQueryLanguage/apply--azure-stream-analytics-.md) operator together with the [GetRecordProperties &#40;Azure Stream Analytics&#41;](../streamAnalyticsQueryLanguage/getrecordproperties--azure-stream-analytics-.md) function. For example, to convert a sample stream into a stream of events with individual sensor readings, this query could be used:  
  
```  
SELECT   
    event.DeviceID,  
    sensorReading.PropertyName,  
    sensorReading.PropertyValue  
FROM input as event  
CROSS APPLY GetRecordProperties(event.SensorReadings) AS sensorReading  
```  
  
 SELECT may also utilize '*' to access all the properties of a nested record. Consider the following query:  
  
```  
SELECT input.SensorReadings.*  
FROM input  
```  
  
 This would result in the following output:  
  
```  
{  
    "Temperature" : 80,  
    "Humidity" : 70,  
    "CustomSensor01" : 5,  
    "CustomSensor022" : 99  
}  
```  
  
## See Also  
 [Data Types &#40;Azure Stream Analytics&#41;](../streamAnalyticsQueryLanguage/data-types--azure-stream-analytics-.md)  
  
  