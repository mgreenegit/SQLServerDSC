<#
.EXAMPLE
    This example shows how to ensure that the user account CONTOSO\SQLAdmin
    is "Owner" of SQL database "AdventureWorks".
#>
Configuration Example
{
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $SysAdminAccount
    )

    Import-DscResource -ModuleName SqlServerDsc

    node localhost
    {
        SqlServerLogin Add_SqlServerLogin_SQLAdmin
        {
            Ensure               = 'Present'
            Name                 = 'CONTOSO\SQLAdmin'
            LoginType            = 'WindowsUser'
            SQLServer            = 'SQLServer'
            SQLInstanceName      = 'DSC'
            PsDscRunAsCredential = $SysAdminAccount
        }

        SqlDatabaseOwner Set_SqlDatabaseOwner_SQLAdmin
        {
            Name                 = 'CONTOSO\SQLAdmin'
            Database             = 'AdventureWorks'
            SQLServer            = 'SQLServer'
            SQLInstanceName      = 'DSC'
            PsDscRunAsCredential = $SysAdminAccount
        }
    }
}
