---
title: "Data Types (Azure Stream Analytics)"
ms.custom: na
ms.date: "2016-07-07"
ms.prod: "azure"
ms.reviewer: na
ms.service: "stream-analytics"
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: "reference"
applies_to: 
  - "Azure"
ms.assetid: f9685302-81db-4f5e-8cea-69ab1af47b2a
caps.latest.revision: 18
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
# Data Types (Azure Stream Analytics)
  In Azure Stream Analytics, each column or scalar expression has a related data type. A data type describes (and constrains) the set of values that a column of that type can hold or an expression of that type can produce.  
 
## Supported data types

 Below is the list of data types supported.  
  
|**Data type**|**Description**|
|-|-|  
|bigint|Integers in the range -2^63 (-9,223,372,036,854,775,808) to 2^63-1 (9,223,372,036,854,775,807).|  
|float|Floating point numbers in the range - 1.79E+308 to -2.23E-308, 0, and 2.23E-308 to 1.79E+308.|  
|nvarchar(max)|Text values, comprised of Unicode characters. Note: A value other than max is not supported.|  
|datetime|Defines a date that is combined with a time of day with fractional seconds that is based on a 24-hour clock and relative to UTC (time zone offset 0).|  
|record|Set of name/value pairs. Values must be of supported data type.|  
|array|Ordered collection of values. Values must be of supported data type.|  
  
 You may join on (or compare) a bigint and a float data type. It will work correctly in all cases except for the case of the very large bigint values that cannot be represented.  
  
## Type conversions
 
These are the rules governing *data type conversions*:  
•   Conversion without precision loss during input read and output write operations is implicit and is always successful  
•   Precision loss and overflow inside output write operations is handled by configured error policy (set to either Drop or Retry)  
•   Type conversion errors happening during output write operations are handled by the error policy  
•   Type conversion errors happening during input read operations cause the job to drop the event

  
## Type mappings and serialization formats:
| Data type  | CSV in  | CSV out  | JSON in  | JSON out  | Avro in  | Avro out  |
|---|---|---|---|---|---|---|
| **bigint**  | string converted to 64 bit signed integer  | 64 bit signed integer converted to string using job culture  | number: integer converted to 64 bit signed integer; <br /><br />Boolean: false is converted to 0, true is converted to 1  | numeric: integer  | long and int converted to 64 bit signed integer; <br /><br />Boolean: false is converted to 0, true is converted to 1  | long  |
| **float**  | string converted to 64 bit signed float point number  | 64 bit signed float point number converted to string using job culture  | number: fraction converted to 64 bit signed float point number  | number: fraction  | double and float converted to 64 bit signed float point number    | double  |
| **nvarchar(max)**  | string  | string  | string  | string  | string  | string  |
| **datetime**  | string converted to datetime following ISO 8601 standard  | string using ISO 8601 standard  | string converted to datetime following ISO 8601 standard  | datetime converted to string using ISO 8601 standard  | string converted to datetime following ISO 8601 standard  | datetime converted to string using ISO 8601 standard  |
| **record**  | N/A  | Not supported, “Record” string is outputted  | JSON object  | JSON object  | Avro record type  | Avro record type  |
| **array**  | N/A  | Not supported,  “Array” string is outputted  | JSON object  | JSON object  | Avro record type  | Avro record type  |
 
## Type mapping when writing to structured data stores:
| Data type | SQL | Power BI | Document DB |
|---------------|-----------------------------------------------------------------------------|---------------------------------------------|------------------------------------------------------|
| **bigint** | bigint, int, smallint, tinyint, all string types (ntext, nvarchar, char, …) | yes | numeric: integer |
| **float** | float, real, decimal, numeric, all string types ( ntext, nvarchar, char, …) | yes | number: fraction |
| **nvarchar(max)** | All string types (ntext, nvarchar, char, uniqueidentifier…) | yes | string |
| **datetime** | datetime, datetime2, datetimeoffset, all string types ( ntext, nvarchar, char, …) | yes | datetime converted to string using ISO 8601 standard |
| **record** | Not supported,  “Record” string is outputted | Not supported,  "Record" string is outputted | JSON object |
| **array** | Not supported,  “Array” string is outputted | Not supported,  “Array” string is outputted | JSON object |