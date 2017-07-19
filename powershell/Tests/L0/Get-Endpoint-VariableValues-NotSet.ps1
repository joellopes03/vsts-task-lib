[CmdletBinding()]
param()

# Arrange.
. $PSScriptRoot\..\lib\Initialize-Test.ps1
$env:ENDPOINT_URL_SOMENAME = 'Some URL'
$env:ENDPOINT_AUTH_SOMENAME = '{ ''SomeProperty'' : ''$(var1)'', ''SomeProperty2'' : ''Some property value 2'' }'
$env:ENDPOINT_DATA_SOMENAME = '{ ''SomeDataProperty'' : ''$(var2)'' }'
Invoke-VstsTaskScript -ScriptBlock {
    # Act.
    $actual = Get-VstsEndpoint -Name 'SomeName'
	
    # Assert.
    Assert-IsNotNullOrEmpty $actual
    Assert-AreEqual 'Some property value 2' $actual.Auth.SomeProperty2
    Assert-IsNullOrEmpty $actual.Auth.SomeProperty
    Assert-IsNullOrEmpty $actual.Data.SomeDataProperty
    Assert-IsNullOrEmpty $env:ENDPOINT_URL_SOMENAME
    Assert-IsNullOrEmpty $env:ENDPOINT_AUTH_SOMENAME
    Assert-IsNullOrEmpty $env:ENDPOINT_DATA_SOMENAME
}