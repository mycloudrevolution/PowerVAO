---
external help file: New-VaoApiConnection-help.xml
Module Name: PowerVAO
online version: https://mycloudrevolution.com/
schema: 2.0.0
---

# New-VaoApiConnection

## SYNOPSIS

## SYNTAX

```
New-VaoApiConnection [-Server] <String> [[-Token] <String>] [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
Connecto to Veeam Availability Orchestrator API.

## EXAMPLES

### EXAMPLE 1
```
$YourCredentials = Get-Credential
New-VaoApiConnection -Server "vao01.lab.local" -Credential $YourCredentials
```

## PARAMETERS

### -Server
FQDN of the Veeam Availability Orchestrator Instance

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token
Existing Token for renewal (not yet implemented)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $Global:VaoApiConnection.Token
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Credential for the Veeam Availability Orchestrator Instance

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
File Name  : New-VaoApiConnectionl.psm1
Author     : Markus Kraus
Version    : 1.0
State      : Test

## RELATED LINKS

[https://mycloudrevolution.com/](https://mycloudrevolution.com/)

[https://helpcenter.veeam.com/docs/vao/restapi/overview.html?ver=10](https://helpcenter.veeam.com/docs/vao/restapi/overview.html?ver=10)

