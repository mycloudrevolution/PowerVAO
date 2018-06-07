---
external help file: Set-VaoFailoverPlan-help.xml
Module Name: PowerVAO
online version: https://mycloudrevolution.com/
schema: 2.0.0
---

# Set-VaoFailoverPlan

## SYNOPSIS

## SYNTAX

### Enable
```
Set-VaoFailoverPlan -PlanID <String> [-Enable] [<CommonParameters>]
```

### Disable
```
Set-VaoFailoverPlan -PlanID <String> [-Disable] [<CommonParameters>]
```

## DESCRIPTION
Modify Veeam Availability Orchestrator FailoverPlan

## EXAMPLES

### EXAMPLE 1
```
Set-VaoFailoverPlan -PlanID ed799d88-30f0-4494-b183-124e171afa91 -Enable
```

### EXAMPLE 2
```
Set-VaoFailoverPlan -PlanID ed799d88-30f0-4494-b183-124e171afa91 -Disable
```

## PARAMETERS

### -PlanID
Failover Plan ID

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Enable
Enable Failover Plan

```yaml
Type: SwitchParameter
Parameter Sets: Enable
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Disable
Disable Failover Plan

```yaml
Type: SwitchParameter
Parameter Sets: Disable
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
File Name  : Set-VaoFailoverPlan.psm1
Author     : Markus Kraus
Version    : 1.0
State      : Test

## RELATED LINKS

[https://mycloudrevolution.com/](https://mycloudrevolution.com/)

