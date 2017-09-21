Sub Macro1()
        
    Dim currentLine As Integer
    currentLine = 9
    
    Dim destinationLine As Integer
    destinationLine = 30
    
    While (currentLine < 50000)
        
        Windows("source.xls").Activate
        
        Dim Donnee1 As String
        Dim SousDonnee1 As String
        Dim Donnee2 As String
        Dim SubDonnee2 As String
        Dim Donnee3 As String
        Dim Donnee4 As String
        Dim Donnee5 As String
         
        If (Left(Range("B" + CStr(currentLine)), 5) = "debutdechaine1") Then
            Donnee1 = Range("B" + CStr(currentLine)).Value
        End If
    
        If (Left(Range("B" + CStr(currentLine)), 8) = "debutdechaine2") Then
            SousDonnee1 = Range("B" + CStr(currentLine)).Value
        End If
       
        If (Left(Range("B" + CStr(currentLine)), 12) = "debutdechaine3") Then
            SousDonnee1 = Range("B" + CStr(currentLine)).Value
        End If
        
        If (Range("C" + CStr(currentLine)).Value <> "") Then
            Donnee2 = Range("C" + CStr(currentLine)).Value
        End If
        
        If (Range("D" + CStr(currentLine)).Value <> "") Then
            SubDonnee2 = Range("D" + CStr(currentLine)).Value
        End If
        
        If (Range("E" + CStr(currentLine)).Value <> "") Then
            Donnee3 = Range("E" + CStr(currentLine)).Value
        End If
        
        If (Range("G" + CStr(currentLine)).Value <> "") Then
            Donnee4 = Range("G" + CStr(currentLine)).Value
        End If
        
        If (Range("H" + CStr(currentLine)).Value <> "") Then
            Donnee5 = Range("H" + CStr(currentLine)).Value
        End If
                
            Dim LibelleTotal As String
            LibelleTotal = Donnee1 + Chr(10) + SousDonnee1 + Chr(10) + Donnee2 + Chr(10) + SubDonnee2
        
            Windows("destination.xls").Activate
            Range("A" + CStr(destinationLine)).Select
            ActiveCell.Value = LibelleTotal
            
            Range("B" + CStr(destinationLine)).Select
            ActiveCell.Value = Donnee3 + Chr(10) + Donnee4
            
            Range("C" + CStr(destinationLine)).Select
            ActiveCell.Value = Donnee5
            
            destinationLine = destinationLine + 1
                                
        
        currentLine = currentLine + 1
        
                             
    Wend
    

End Sub
