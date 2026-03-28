---
layout: post
title: MongoDb Provider for MS FHIR Server - Part 1
description: MongoDb Provider for MS FHIR Server
published: true
tags:
- dotnet
- csharp
- fhir
- mongodb
---

> MongoDb Storage Driver for Microsoft FHIR Server - Part 1

## TL;DR;

My original plan was to get this whole thing up and running with a big bang, but that was proving to be more of a ...

## Introduction

This article discusses the first steps in a [MongoDb](https://www.mongodb.com/) Storage Driver for the [Microsoft FHIR Server](https://github.com/microsoft/fhir-server).

The first

1. Resource Storage.  POST, including batch bundles with POST.  PUT as a side effect, but simply flush and fill at this stage.  [FHIR RESTful API Definition](https://build.fhir.org/http.html).
1. Simple Query.  Single Resource Query Support.
1. Test Harnesses
    1. REST
    1. Python

The basis for the implementaion is the FHIR R4 Standard, however many of the links here are to the 'CI' version of the FHIR documentation and definitions.  Any discrepences will result in a R4 wins implementation.

## Implementation

### Storage

Each FHIR resource is stored as a Documnet in a single MongoDb database within a single MongoDb collection.

| Concept | 	Analogous to (SQL)	Description |
| ------- | ------------------------------------|
| Database |	Database/Schema	A physical container for storing and organizing collections, providing logical isolation for data. |
| Collection |	Table	A group of BSON (Binary JSON) documents. Documents within a single collection do not need to have the same set of fields (schema-less). |
| Document |	Row/Record	A single data record, stored as field-value pairs in a JSON-like format. Fields are analogous to columns. |

Each document contains the following top level properties:

1. resource: [Object].  The Complete FHIR Resource
1. isDeleted: [Boolean].  Soft Delete Flag
1. searchIndexes: [Array].  Search Indexes for the Resource.

search indexes are stored as part of the document because ---

Assembly Microsoft.Health.Fhir.MongoDb

```csharp
namespace Microsoft.Health.Fhir.MongoDb.Features.Storage
{
    public sealed class MongoFhirDataStore : IFhirDataStore, IProvideCapability
    {
        //...
    }
}
```

1. look to see if the resource exists
1. creates the document
1. builds indexes.  TODO:  Review : `SearchIndexEntryBsonDocumentGenerator` and describe
    searchIndexes is an array of Objects.  Each object has two properties, the SearchParamter object and the Value Object.  We will discuss more under search, but the general pattern is that for the list of IReadOnlyCollection&lt;SearchIndexEntry&gt; searchIndices provided resource wrapper we will save an object in JSON that is built into the mongo filter generation
    as we get farther along we will probably want to make tis storage smaller, for now it is easier for development, but ultimately we may only need code, and perhaps type depending on how we want to look at it.
1. submits to database engine

### Search

Microsoft FHIR server parses the incoming query into and dispatches the call to the registered FhirMongoSearchService class.

```csharp
    internal class FhirMongoSearchService : SearchService
    {
        public override async Task<SearchResult> SearchAsync(SearchOptions searchOptions, CancellationToken cancellationToken){
            // ...
        }
    }
```

uses elemmatch on searchIndexes.

Fundamentally Search builds BsonDocumnets that are sent to the mongo engine for execution

[FHIR Search](https://build.fhir.org/search.html)

#### Search Types

Following is a condensed summary of [FHIR Types and Type Mapping](https://build.fhir.org/search.html#type-mapping).

| Search Type | Short | FHIR Types |
| ----------- | ----- | ---------- |
| date | Partial or complete date or time values | date, dateTime, instant, Period, Timing |
| number | Numbers of various types | decimal, integer, integer64, unsignedInt, positiveInt |
| quantity | Quantity values (including currencies) | Age, Count, Distance, Duration, MoneyQuantity, Quantity, SimpleQuantity |
| reference | References to other resources | canonical, OID, URI, URL, UUID, Reference |
| string | String values | id, markdown, string, xHTML |
| token | Token values | boolean, canonical, code, CodeableConcept, Coding, ContactPoint, id, Identifier, OID, string, URI, URL, UUID |
| uri | URI values | canonical, OID, URI, URL, UUID |

#### date

#### number

#### quantity

[quantity](https://build.fhir.org/search.html#quantity)

see notes in Journal





```csharp

    //in namepace Microsoft.Health.Fhir.ValueSets

    public enum SearchParamType
    {
        [EnumLiteral("number")]
        Number,
        [EnumLiteral("date")]
        Date,
        [EnumLiteral("string")]
        String,
        [EnumLiteral("token")]
        Token,
        [EnumLiteral("reference")]
        Reference,
        [EnumLiteral("quantity")]
        Quantity,
        [EnumLiteral("uri")]
        Uri,
        [EnumLiteral("composite")]
        Composite,
        [EnumLiteral("special")]
        Special,
    }
```

### Search Modifiers

See [FHIR Search Modifiers](https://build.fhir.org/search.html#modifiers) for comprehensive discussion.

https://build.fhir.org/codesystem-search-modifier-code.html

Microsoft.Health.Fhir.ValueSets.SearchModifierCode

| modifier | applies to | notes |
|----------|------------|-------|
| above | | not initial focus|
| below | | not initial focus |
| code-text | | |
| contains | reference, string, uri | implemented |
| exact | | implemented |
| identifier | | |
| in | | |
| iterate | | |
| missing | | |
| not | | |
| not-in | | |
| of-type | | |
| text | reference, token | |
| text | string | |
| text-advanced | reference, token | |
| [type] | reference | |

### Prefixes / Search Comparators

[Search Comparators](https://hl7.org/fhir/codesystem-search-comparator.html)

[FHIR codesystem definition](https://hl7.org/fhir/codesystem-search-comparator.html)

| Prefix Code | Description |
| ----------- | ----------- |
| eq | the resource value is equal to or fully contained by the parameter value |
| ne | |
| gt | |
| lt | |
| ge | |
| le | |
| sa | |
| eb | |
| ap | |


## Test Harness


## Journal

| Date | Entry | Is TODO | Done |
| ----------- | ----------- | -- | --|
| 20250626 | Make sure that all of these are implemented - https://learn.microsoft.com/en-us/azure/healthcare-apis/fhir/search-samples | yes | |
| 20250626 | update on 20250625 they system and code are designed for units of measure in a `quantity` type, not the coding system of what is being measures.  Leaving in below note to remind myself of mis-understanding.
| 20250625 | working through quantity search.  look at the data in `test_suite_search_type_quantity.json` and then cross reference that with the py file to see what is going on.  Need to do some more research on hoe microsoft FHIR is generating and sending in `IReadOnlyCollection&lt;SearchIndexEntry%gt; searchIndices` to GenerateSearchIndexes, then how the query is generated.  For the entry in question.  also some more review of [composite search parameters](https://build.fhir.org/search.html#composite) and how to call those out.  The resource in question seems a little concocted since to pass validation we send in the code twice.   | | |
