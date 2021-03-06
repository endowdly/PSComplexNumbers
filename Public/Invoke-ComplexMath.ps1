﻿#  System.Numerics.Complex supports standard binary operators.
#  Since they are supported,  they will not be added in this function.

#  System.Math methods will not transmute for Numerics.Complex methods.
#  So they are included.

#  This function will focus on easy access to the most common unary operations:
#  Conjugate,  Negate,  and Reciprocal.

function Invoke-ComplexMath { 
    <#
        .SYNOPSIS
            Allows easy access to Numerics.Complex methods.
            
        .DESCRIPTION
            Allows easy access to Numerics.Complex methods.
            
            System.Numerics.Complex supports standard binary operators ('-', '+', '*', '/').
            Because basic operators are supported,  they are not included here. 
            
        .PARAMETER Object
            The object to be passed or the first argument in binary operations.
            
        .PARAMETER Argument
            The second object to be passed or the second argument in binary operations.
            
        .PARAMETER Conjugate
            Find the conjugate of Object. This is the default operation.
            
        .PARAMETER Reciprocal
            Find the reciprocal of Object.
            
        .PARAMETER Negate
            Find the negation of Object.
            
        .PARAMETER Abs
            Return the absolute magnitude of Object.
            
        .PARAMETER Acos
            Find the angle of cosine of Object.
            
        .PARAMETER Asin
            Find the angle of sine of Object.
            
        .PARAMETER Atan
            Find the angle of tangent of Object.
            
        .PARAMETER Cos
            Find the cosine of Object.
            
        .PARAMETER Cosh
            Find the hyperbolic cosine of Object.
        
        .PARAMETER Exp
            Find solution to e raised to the Object power.
        
        .PARAMETER Log10
            Find the base 10 log of Object.
            
        .PARAMETER Sin
            Find the hyperbolic sine of Object.
        
        .PARAMETER Sinh
            Find the hyperbolic sine of Object.
        
        .PARAMETER Sqrt
            Find the square root of Object.
        
        .PARAMETER Tan
            Find the tangent of Object.
        
        .PARAMETER Tanh
            Find the hyperbolic tangent of Object.
        
        .PARAMETER Pow
            Find the power of Object raised to the Argument.
        
        .PARAMETER Log
            Find the base Argument log of Object.
        
        .INPUTS
            Object is a Numerics.Complex object.
            Argument is either a Numerics.Complex object or a numeric value.
        
        .OUTPUTS
            System.Numerics.Complex object
        
        .EXAMPLE
            PS> Invoke-ComplexMath -Negate $m
            Real            Imaginary            Magnitude               Phase
            ----            ---------            ---------               -----
              -2                   -3     3.60555127546399   -2.15879893034246
        
        .EXAMPLE
            PS> $n, $m | Invoke-ComplexMath -Abs
            3.16227766016838
            3.60555127546399
            
            Description
            -----------
            Demonstrating use of the Pipeline for Unary Operations.
            
        .EXAMPLE
            PS> Invoke-ComplexMath -Log $m 2
            Real            Imaginary            Magnitude               Phase
            ----            ---------            ---------               -----
1.85021985907055     1.41787163074572     2.33102412861226   0.653868149497725

            Description
            -----------
            Demonstrating use of the binary operation 'Log'.
        
        .LINK
            Show-ComplexNumber
        
        .LINK
            New-ComplexNumber
    #>

    [CmdLetBinding(DefaultParameterSetName='Conjugate')]
    [OutputType([System.Numerics.Complex])]
    
    param (
        [Parameter(Mandatory=1, 
                   Position=0, 
                   ValueFromPipeline=1, 
                   ValueFromPipelineByPropertyName=1, 
                   HelpMessage='Enter complex object')]
        [Numerics.Complex] $Object, 
        
        [Parameter(ParameterSetName='Conjugate')]
        [Switch] $Conjugate, 
        
        [Parameter(ParameterSetName='Reciprocal')]
        [Switch] $Reciprocal, 
        
        [Parameter(ParameterSetName='Negate')]
        [Switch] $Negate, 
        
        [Parameter(ParameterSetName='Abs')]
        [Switch] $Abs, 
        
        [Parameter(ParameterSetName='Acos')]
        [Switch] $Acos, 
        
        [Parameter(ParameterSetName='Asin')]
        [Switch] $Asin, 
        
        [Parameter(ParameterSetName='Atan')]
        [Switch] $Atan, 
        
        [Parameter(ParameterSetName='Cos')]
        [Switch] $Cos, 
        
        [Parameter(ParameterSetName='Cosh')]
        [Switch] $Cosh, 
        
        [Parameter(ParameterSetName='Exp')]
        [Switch] $Exp, 
        
        [Parameter(ParameterSetName='Log10')]
        [Switch] $Log10, 
        
        [Parameter(ParameterSetName='Sin')]
        [Switch] $Sin, 
        
        [Parameter(ParameterSetName='Sinh')]
        [Switch] $Sinh, 
        
        [Parameter(ParameterSetName='Sqrt')]
        [Switch] $Sqrt, 
        
        [Parameter(ParameterSetName='Tan')]
        [Switch] $Tan, 
        
        [Parameter(ParameterSetName='Tanh')]
        [Switch] $Tanh, 
        
        [Parameter(ParameterSetName='Pow')]
        [Switch] $Pow, 
        
        [Parameter(ParameterSetName='Log')]
        [Switch] $Log, 
        
        [Parameter(ParameterSetName='Pow', 
                   Mandatory=1, 
                   Position=1, 
                   ValueFromPipelineByPropertyName=1, 
                   HelpMessage='Enter an argument. Can be complex or real')]
        [Parameter(ParameterSetName='Log', 
                   Mandatory=1, 
                   Position=1, 
                   ValueFromPipelineByPropertyName=1, 
                   HelpMessage='Enter an argument. Can be complex or real')]
        [ValidateScript({ 
            if ($_ -isnot [Numerics.Complex]) {
                try { 
                    $_ -as [double] 
                } 
                catch { 
		    $invalidArgType = "$_ is not a valid argument type; " +
		    	'provide a number,  string numeric,  or a complex object'
                    throw $invalidArgType
                }
            }
        })]
        $Argument  # Can be multiple types
    )# __param
    
    begin {
        $method = $PSCmdlet.ParameterSetName
        
        function UnaryOp {
            [Numerics.Complex]::$method.Invoke($Object)
        }
        
        function BinaryOp {
            [Numerics.Complex]::$method.Invoke($Object, $Argument)
        }
    }
    
    process {
    
        switch ($PSCmdlet.ParameterSetName) {
            
            #     Unary Set   
            # vvvvvvvvvvvvvvvvv
            'Conjugate'  { UnaryOp }
            'Reciprocal' { UnaryOp }
            'Negate'     { UnaryOp }
            'Abs'        { UnaryOp }
            'Acos'       { UnaryOp }
            'Asin'       { UnaryOp }
            'Atan'       { UnaryOp }
            'Cos'        { UnaryOp }
            'Cosh'       { UnaryOp }
            'Exp'        { UnaryOp }
            'Log10'      { UnaryOp }
            'Sin'        { UnaryOp }
            'Sinh'       { UnaryOp }
            'Sqrt'       { UnaryOp }
            'Tan'        { UnaryOp }
            'Tanh'       { UnaryOp }
            #^^^^^^^^^^^^^^^^^
            
            #     Binary Set   
            # vvvvvvvvvvvvvvvvvv
            'Pow'        { BinaryOp }
            'Log'        { BinaryOp }
            #^^^^^^^^^^^^^^^^^
        }
            
    }# __process
}# __func

# __END__
