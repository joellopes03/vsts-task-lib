[CmdletBinding()]
param()

# Arrange.
. $PSScriptRoot\..\lib\Initialize-Test.ps1
$env:ENDPOINT_URL_SOMENAME = 'Some URL'
$env:VAR1 = 'value1'
$env:VAR2 = 'value2'
$env:ENDPOINT_AUTH_SOMENAME = '{ ''SomeProperty'' : ''$(var1)'', ''SomeProperty2'' : ''Some property value 2'' }'
$env:ENDPOINT_DATA_SOMENAME = '{ ''SomeDataProperty'' : ''$(var2)'' }'
Invoke-VstsTaskScript -ScriptBlock {
    # Act.
    $actual = Get-VstsEndpoint -Name 'SomeName'

    # Assert.
    Assert-IsNotNullOrEmpty $actual
    Assert-AreEqual 'Some URL' $actual.Url
    Assert-AreEqual 'value1' $actual.Auth.SomeProperty
    Assert-AreEqual 'Some property value 2' $actual.Auth.SomeProperty2
    Assert-AreEqual 'value2' $actual.Data.SomeDataProperty
    Assert-IsNullOrEmpty $env:ENDPOINT_URL_SOMENAME
    Assert-IsNullOrEmpty $env:ENDPOINT_AUTH_SOMENAME
    Assert-IsNullOrEmpty $env:ENDPOINT_DATA_SOMENAME
}