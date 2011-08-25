/*
 * Proyecto: PruebaMVC
 * Fichero: P01.prg
 * Descripción: Ejemplo modo texto de las clases.
 * Autor: Jose Alfonso Suarez Moreno
 *        Manu Exposito Suárez
 * Fecha: 24/08/2011
 * Version: 0.09
 */

#include "hbclass.ch"
#include "box.ch"
#include "inkey.ch"

REQUEST HB_GT_WIN

//-----------------------------------------------------------------------------
// Programa principal de la prueba

FUNCTION main()
    LOCAL miEj := miEjemplo()
    miEj:run()
RETURN nil

//-----------------------------------------------------------------------------
// Clase principal para el ejemplo de pruebas con ArrayList etc

CLASS miEjemplo
    METHOD run()
    METHOD gesBrw()
ENDCLASS

//-----------------------------------------------------------------------------

METHOD run() CLASS miEjemplo

    LOCAL al := ArrayList():new()
    LOCAL nv, n := 0, kk, a := {}

    // Relleno del array a con objetos String
    AAdd( a, String():new("X") )
    AAdd( a, String():new("Y") )
    AAdd( a, String():new("Z") )
    AAdd( a, String():new("W") )
    AAdd( a, String():new("U") )

    cls

    al:add( String():new("1") )
    al:add( String():new("2") )
    al:add( String():new("3") )
    al:add( String():new("4") )
    al:add( String():new("5") )
    al:add( String():new("A") )
    al:add( String():new("B") )
    al:add( String():new("C") )
    al:add( String():new("D") )
    al:add( String():new("E") )
    al:add( String():new("F") )

    // Queeeee potencia el metodo addAll admite tambien arrays
    al:addAll( a )

    System():Out():print( "Contents of al: " )
    System():Out():println( al )

    nv := al:navigator()

    nv:goTop()

    WHILE !nv:eof()
        System():Out:print( "Registro: " + AllTrim( str( nv:RecNo() ) ) + " " )
        System():Out:println( nv:getCurrentItem() )
        nv:skip()
    END

    ?
    inKey( 100 )
    ?
    System():Out():println( "Backward:" )
    ?

    WHILE !nv:bof()
        System():Out:print( "Registro: " + AllTrim( str( nv:RecNo() ) ) + " " )
        System():Out:println( nv:getCurrentItem() )
        nv:skip( -1 )
    END

    ?
    System():Out:println( "Y ahota en un browse..." )
    inKey( 100 )
    ?

    cls

    ::gesBrw( nv )

    cls

    Alert( "Borramos desde 6 a 11" )
    al:removeRange( 6, 11 )
    nv:goTop()
    ::gesBrw( nv )

    nv:goTop()
    WHILE nv:hasNext()
        nv:next():setString( AllTrim( StrZero( ++n, 2 ) ) )
    END

    nv:goTop()
    ::gesBrw( nv )

RETURN nil

//-----------------------------------------------------------------------------

METHOD gesBrw( nv ) CLASS miEjemplo

    LOCAL lEnd := .f., nKey
    LOCAL oBrw := TBrowseNew( 5, 5, 10, 10 )

    @ 0, 0  SAY "Elementos -> " + nv:getArrayList():toString()
    @ 5, 15 SAY "Presiona ENTER para seleccionar un valor"
    @ 9, 15 SAY "Presiona ESCAPE para salir"

    DispBox(4, 4, 11, 11, B_SINGLE + ' ', "W+/B" )

    oBrw:colorSpec := "W+/B, N/BG"
    oBrw:headSep := "-"
    oBrw:goTopBlock := { || nv:goTop() }
    oBrw:goBottomBlock := { || nv:goBottom() }
    oBrw:skipBlock := { | nSkip | nv:skip( nSkip ) }
    oBrw:addColumn( TBColumnNew( "Col",  { || nv:getCurrentItem():toString() } ) )

    WHILE !lEnd
        DispBegin()
            oBrw:ForceStable()
        DispEnd()
        nKey = InKey( 0 )

        DO CASE
            CASE nKey == K_ESC
                lEnd = .t.

            CASE nKey == K_DOWN
                oBrw:Down()

            CASE nKey == K_UP
                oBrw:Up()

            CASE nKey = K_PGDN
                oBrw:pageDown()

            CASE nKey == K_PGUP
                oBrw:pageUp()

            CASE nKey = K_CTRL_PGUP
                oBrw:goTop()

            CASE nKey == K_CTRL_PGDN
                oBrw:goBottom()

            CASE nKey = K_HOME
                oBrw:home()

            CASE nKey == K_END
                oBrw:end()

            CASE nKey == K_ENTER
                @ 7, 15 SAY "Valor selecionado: " + nv:getCurrentItem():toString()

        ENDCASE

    END

RETURN nil

//-----------------------------------------------------------------------------
// Clase adicional para las pruebas

#include "emuclases.prg"

//-----------------------------------------------------------------------------

