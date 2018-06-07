---
external help file: Invoke-VaoApiCall-help.xml
Module Name: PowerVAO
online version: https://mycloudrevolution.com/
schema: 2.0.0
---

# Invoke-VaoApiCall

## SYNOPSIS

## SYNTAX

```
Invoke-VaoApiCall [[-Server] <String>] [[-Token] <String>] [-Uri] <String> [[-Accept] <String>]
 [-Method] <String> [[-Body] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Helper function to call the Veeam Availability Orchestrator API.

## EXAMPLES

### EXAMPLE 1
```
Invoke-VaoApiCall -Uri "/v1/About" -Method Get
```

## PARAMETERS

### -Server
FQDN of the Veeam Availability Orchestrator Instance

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $Global:VaoApiConnection.Server
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token
Bearer Token for the Veeam Availability Orchestrator Instance

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $Global:VaoApiConnection.access_token
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
API Uri for the Call

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Accept
Accept Header for the API Call

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Application/json, text/json, text/html, application/xml, text/xml
Accept pipeline input: False
Accept wildcard characters: False
```

### -Method
Method of the API Call

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Body
Body of the API Call

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
File Name  : Invoke-VaoApiCall.psm1
Author     : Markus Kraus
Version    : 1.0
State      : Test

## RELATED LINKS

[https://mycloudrevolution.com/](https://mycloudrevolution.com/)

[https://helpcenter.veeam.com/docs/vao/restapi/overview.html?ver=10](https://helpcenter.veeam.com/docs/vao/restapi/overview.html?ver=10)

