#dans le même dossier que le script à analyser

@{
    Rules = @{
        PSUseConsistentIndentation = @{
            Enable = $true
        }
        PSAvoidUsingWriteHost = @{
            Enable = $true
        }
        PSUseDeclaredVarsMoreThanAssignments = @{
            Enable = $true
        }
    }

    Severity = @{
        PSUseConsistentIndentation = 'Warning'
        PSAvoidUsingWriteHost = 'Error'
    }
}
