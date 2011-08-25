/*
 * Proyecto: PruebaMVC
 * Fichero: EmuClases.prg
 * Descripción: Emula alguna de las clases de Java.
 * Autor: Jose Alfonso Suarez Moreno
 *        Manu Exposito Suárez
 * Fecha: 24/08/2011
 * Version: 0.09
 */
//-----------------------------------------------------------------------------

#include "hbclass.ch"

//-----------------------------------------------------------------------------
// Clase system

CLASS System FROM Object
    DATA Out INIT Out()
END CLASS

//-----------------------------------------------------------------------------
// Clase Out

CLASS Out FROM Object
    METHOD print( object )
    METHOD printLn( object )
END CLASS

METHOD print( object ) CLASS Out
    IF ValType( object ) == "O"
        QOut( object:toString() )
    ELSE
        QOut( object )
    END IF
RETURN nil

METHOD println( object ) CLASS Out
    IF ValType( object ) == "O"
        QQOut( object:toString() )
    ELSE
        QQOut( object )
    END IF
RETURN nil

//-----------------------------------------------------------------------------
// Clase String

CLASS String FROM Object
    DATA s
    METHOD new( s )
    METHOD setString( s ) INLINE ::s := s
    METHOD toString() INLINE ::s
END CLASS

METHOD new( s ) CLASS String
    ::s := s
RETURN self

//-----------------------------------------------------------------------------



