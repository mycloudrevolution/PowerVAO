---
external help file: Get-VaoSite-help.xml
Module Name: PowerVAO
online version: https://mycloudrevolution.com/
schema: 2.0.0
---

# Get-VaoSite

## SYNOPSIS

## SYNTAX

```
Get-VaoSite [[-SiteID] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get Veeam Availability Orchestrator Sites

## EXAMPLES

### EXAMPLE 1
```
Get-VaoSite | Select-Object name, id, serverName, type | ft -AutoSize
```

### EXAMPLE 2
```
Get-VaoSite -SiteID 850316df-d73f-4e8b-b8bc-7b1815fb0a9e | Select-Object name, id, serverName, type | ft -AutoSize
```

## PARAMETERS

### -SiteID
Optional Veeam Availability Orchestrator Site ID

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
File Name  : Get-VaoSite.psm1
Author     : Markus Kraus
Version    : 1.0
State      : Test

## RELATED LINKS

[https://mycloudrevolution.com/](https://mycloudrevolution.com/)

