pragma solidity ^0.5.2;

contract MimcConstraintPoly {
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    function() external {
        uint256 res;
        assembly {
            let PRIME := 0x30000003000000010000000000000001
            
            calldatacopy(0x0, 0x0,  0xca0)
            let point :=  mload(0x3c0)
            
            mstore(0xca0, mul(2,  mload(0x2c0)))
            function expmod(base, exponent, modulus) -> res {
              let p :=  0x10c0
              mstore(p, 0x20)                 
              mstore(add(p, 0x20), 0x20)      
              mstore(add(p, 0x40), 0x20)      
              mstore(add(p, 0x60), base)      
              mstore(add(p, 0x80), exponent)  
              mstore(add(p, 0xa0), modulus)   
              
              if iszero(staticcall(not(0), 0x05, p, 0xc0, p, 0x20)) {
                revert(0, 0)
              }
              res := mload(p)
            }

            function degreeAdjustment(compositionPolynomialDegreeBound, constraintDegree, numeratorDegree,
                                       denominatorDegree) -> res {
              res := sub(sub(compositionPolynomialDegreeBound, 1),
                         sub(add(constraintDegree, numeratorDegree), denominatorDegree))
            }

            {
              

              
              mstore(0xf40, expmod(point,  mload(0x2c0), PRIME))

              
              mstore(0xf60, expmod( mload(0x3a0), sub( mload(0x2c0), 1), PRIME))

            }

            {
              

              
              
              mstore(0xfe0,
                     addmod( mload(0xf40), sub(PRIME, 1), PRIME))

              
              
              mstore(0x1000,
                     addmod(point, sub(PRIME, 1), PRIME))

              
              
              mstore(0x1020,
                     addmod(point, sub(PRIME,  mload(0xf60)), PRIME))

            }

            {
              

              
              
              
              
              
              let productsToValuesOffset := 0x60
              let prod := 1
              let partialProductEndPtr := 0xfe0
              for { let partialProductPtr := 0xf80 }
                  lt(partialProductPtr, partialProductEndPtr)
                  { partialProductPtr := add(partialProductPtr, 0x20) } {
                  mstore(partialProductPtr, prod)
                  
                  prod := mulmod(prod,
                                 mload(add(partialProductPtr, productsToValuesOffset)),
                                 PRIME)
              }

              let firstPartialProductPtr := 0xf80
              
              let prodInv := expmod(prod, sub(PRIME, 2), PRIME)

              if eq(prodInv, 0) {
                  
                  
                  
                  
                  

                  mstore(0, 0x08c379a000000000000000000000000000000000000000000000000000000000)
                  mstore(0x4, 0x20)
                  mstore(0x24, 0x1e)
                  mstore(0x44, "Batch inverse product is zero.")
                  revert(0, 0x62)
              }

              
              
              
              let currentPartialProductPtr := 0xfe0
              for { } gt(currentPartialProductPtr, firstPartialProductPtr) { } {
                  currentPartialProductPtr := sub(currentPartialProductPtr, 0x20)
                  
                  mstore(currentPartialProductPtr,
                         mulmod(mload(currentPartialProductPtr), prodInv, PRIME))
                  
                  prodInv := mulmod(prodInv,
                                     mload(add(currentPartialProductPtr, productsToValuesOffset)),
                                     PRIME)
              }
            }

            {
              

              
              
              mstore(0x1040,
                     addmod(point, sub(PRIME,  mload(0xf60)), PRIME))

              
              
              mstore(0x1060,
                     expmod(point, degreeAdjustment( mload(0xca0), mul(3, sub( mload(0x2c0), 1)), 0,  mload(0x2c0)), PRIME))

              
              
              mstore(0x1080,
                     expmod(point, degreeAdjustment( mload(0xca0), mul(3, sub( mload(0x2c0), 1)), 1,  mload(0x2c0)), PRIME))

              
              
              mstore(0x10a0,
                     expmod(point, degreeAdjustment( mload(0xca0), sub( mload(0x2c0), 1), 0, 1), PRIME))

            }

            {
              

              {
              
              let val := addmod(
                mulmod(
                   mload(0x280),
                  addmod(
                     mload(0x9e0),
                    sub(PRIME,  mload(0x0)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x2a0),
                  addmod(
                     mload(0xb40),
                    sub(PRIME,  mload(0x140)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xcc0, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x2e0),
                  addmod(
                     mload(0x9e0),
                    sub(PRIME,  mload(0x0)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x300),
                  addmod(
                     mload(0xb40),
                    sub(PRIME,  mload(0x140)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xce0, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x280),
                  addmod(
                     mload(0xa20),
                    sub(PRIME,  mload(0x20)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x2a0),
                  addmod(
                     mload(0xb80),
                    sub(PRIME,  mload(0x160)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xd00, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x2e0),
                  addmod(
                     mload(0xa20),
                    sub(PRIME,  mload(0x20)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x300),
                  addmod(
                     mload(0xb80),
                    sub(PRIME,  mload(0x160)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xd20, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x280),
                  addmod(
                     mload(0xa40),
                    sub(PRIME,  mload(0x40)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x2a0),
                  addmod(
                     mload(0xba0),
                    sub(PRIME,  mload(0x180)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xd40, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x2e0),
                  addmod(
                     mload(0xa40),
                    sub(PRIME,  mload(0x40)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x300),
                  addmod(
                     mload(0xba0),
                    sub(PRIME,  mload(0x180)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xd60, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x280),
                  addmod(
                     mload(0xa60),
                    sub(PRIME,  mload(0x60)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x2a0),
                  addmod(
                     mload(0xbc0),
                    sub(PRIME,  mload(0x1a0)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xd80, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x2e0),
                  addmod(
                     mload(0xa60),
                    sub(PRIME,  mload(0x60)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x300),
                  addmod(
                     mload(0xbc0),
                    sub(PRIME,  mload(0x1a0)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xda0, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x280),
                  addmod(
                     mload(0xa80),
                    sub(PRIME,  mload(0x80)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x2a0),
                  addmod(
                     mload(0xbe0),
                    sub(PRIME,  mload(0x1c0)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xdc0, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x2e0),
                  addmod(
                     mload(0xa80),
                    sub(PRIME,  mload(0x80)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x300),
                  addmod(
                     mload(0xbe0),
                    sub(PRIME,  mload(0x1c0)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xde0, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x280),
                  addmod(
                     mload(0xaa0),
                    sub(PRIME,  mload(0xa0)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x2a0),
                  addmod(
                     mload(0xc00),
                    sub(PRIME,  mload(0x1e0)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xe00, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x2e0),
                  addmod(
                     mload(0xaa0),
                    sub(PRIME,  mload(0xa0)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x300),
                  addmod(
                     mload(0xc00),
                    sub(PRIME,  mload(0x1e0)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xe20, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x280),
                  addmod(
                     mload(0xac0),
                    sub(PRIME,  mload(0xc0)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x2a0),
                  addmod(
                     mload(0xc20),
                    sub(PRIME,  mload(0x200)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xe40, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x2e0),
                  addmod(
                     mload(0xac0),
                    sub(PRIME,  mload(0xc0)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x300),
                  addmod(
                     mload(0xc20),
                    sub(PRIME,  mload(0x200)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xe60, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x280),
                  addmod(
                     mload(0xae0),
                    sub(PRIME,  mload(0xe0)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x2a0),
                  addmod(
                     mload(0xc40),
                    sub(PRIME,  mload(0x220)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xe80, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x2e0),
                  addmod(
                     mload(0xae0),
                    sub(PRIME,  mload(0xe0)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x300),
                  addmod(
                     mload(0xc40),
                    sub(PRIME,  mload(0x220)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xea0, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x280),
                  addmod(
                     mload(0xb00),
                    sub(PRIME,  mload(0x100)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x2a0),
                  addmod(
                     mload(0xc60),
                    sub(PRIME,  mload(0x240)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xec0, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x2e0),
                  addmod(
                     mload(0xb00),
                    sub(PRIME,  mload(0x100)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x300),
                  addmod(
                     mload(0xc60),
                    sub(PRIME,  mload(0x240)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xee0, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x280),
                  addmod(
                     mload(0xb20),
                    sub(PRIME,  mload(0x120)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x2a0),
                  addmod(
                     mload(0xc80),
                    sub(PRIME,  mload(0x260)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xf00, val)
              }


              {
              
              let val := addmod(
                mulmod(
                   mload(0x2e0),
                  addmod(
                     mload(0xb20),
                    sub(PRIME,  mload(0x120)),
                    PRIME),
                  PRIME),
                mulmod(
                   mload(0x300),
                  addmod(
                     mload(0xc80),
                    sub(PRIME,  mload(0x260)),
                    PRIME),
                  PRIME),
                PRIME)
              mstore(0xf20, val)
              }


              {
              
              let val := addmod(
                 mload(0xa20),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xcc0),
                       mload(0xcc0),
                      PRIME),
                     mload(0xcc0),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x3e0),
                                       mulmod( mload(0x400),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xb80),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xce0),
                       mload(0xce0),
                      PRIME),
                     mload(0xce0),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x420),
                                       mulmod( mload(0x440),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xa40),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xd00),
                       mload(0xd00),
                      PRIME),
                     mload(0xd00),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x460),
                                       mulmod( mload(0x480),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xba0),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xd20),
                       mload(0xd20),
                      PRIME),
                     mload(0xd20),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x4a0),
                                       mulmod( mload(0x4c0),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xa60),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xd40),
                       mload(0xd40),
                      PRIME),
                     mload(0xd40),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x4e0),
                                       mulmod( mload(0x500),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xbc0),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xd60),
                       mload(0xd60),
                      PRIME),
                     mload(0xd60),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x520),
                                       mulmod( mload(0x540),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xa80),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xd80),
                       mload(0xd80),
                      PRIME),
                     mload(0xd80),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x560),
                                       mulmod( mload(0x580),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xbe0),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xda0),
                       mload(0xda0),
                      PRIME),
                     mload(0xda0),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x5a0),
                                       mulmod( mload(0x5c0),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xaa0),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xdc0),
                       mload(0xdc0),
                      PRIME),
                     mload(0xdc0),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x5e0),
                                       mulmod( mload(0x600),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xc00),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xde0),
                       mload(0xde0),
                      PRIME),
                     mload(0xde0),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x620),
                                       mulmod( mload(0x640),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xac0),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xe00),
                       mload(0xe00),
                      PRIME),
                     mload(0xe00),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x660),
                                       mulmod( mload(0x680),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xc20),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xe20),
                       mload(0xe20),
                      PRIME),
                     mload(0xe20),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x6a0),
                                       mulmod( mload(0x6c0),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xae0),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xe40),
                       mload(0xe40),
                      PRIME),
                     mload(0xe40),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x6e0),
                                       mulmod( mload(0x700),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xc40),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xe60),
                       mload(0xe60),
                      PRIME),
                     mload(0xe60),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x720),
                                       mulmod( mload(0x740),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xb00),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xe80),
                       mload(0xe80),
                      PRIME),
                     mload(0xe80),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x760),
                                       mulmod( mload(0x780),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xc60),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xea0),
                       mload(0xea0),
                      PRIME),
                     mload(0xea0),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x7a0),
                                       mulmod( mload(0x7c0),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xb20),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xec0),
                       mload(0xec0),
                      PRIME),
                     mload(0xec0),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x7e0),
                                       mulmod( mload(0x800),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xc80),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xee0),
                       mload(0xee0),
                      PRIME),
                     mload(0xee0),
                    PRIME)),
                PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x820),
                                       mulmod( mload(0x840),
                                              mload(0x1060),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xa00),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xf00),
                       mload(0xf00),
                      PRIME),
                     mload(0xf00),
                    PRIME)),
                PRIME)

              
              
              val := mulmod(val, mload(0x1040), PRIME)
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x860),
                                       mulmod( mload(0x880),
                                              mload(0x1080),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod(
                 mload(0xb60),
                sub(
                  PRIME,
                  mulmod(
                    mulmod(
                       mload(0xf20),
                       mload(0xf20),
                      PRIME),
                     mload(0xf20),
                    PRIME)),
                PRIME)

              
              
              val := mulmod(val, mload(0x1040), PRIME)
              
              
              val := mulmod(val, mload(0xf80), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x8a0),
                                       mulmod( mload(0x8c0),
                                              mload(0x1080),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod( mload(0x9e0), sub(PRIME,  mload(0x320)), PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xfa0), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x8e0),
                                       mulmod( mload(0x900),
                                              mload(0x10a0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod( mload(0xb20), sub(PRIME,  mload(0x340)), PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xfc0), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x920),
                                       mulmod( mload(0x940),
                                              mload(0x10a0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod( mload(0xb40), sub(PRIME,  mload(0x360)), PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xfa0), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x960),
                                       mulmod( mload(0x980),
                                              mload(0x10a0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              
              let val := addmod( mload(0xc80), sub(PRIME,  mload(0x380)), PRIME)

              
              
              
              
              
              val := mulmod(val, mload(0xfc0), PRIME)

              
              res := addmod(res,
                            mulmod(val,
                                   add( mload(0x9a0),
                                       mulmod( mload(0x9c0),
                                              mload(0x10a0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

            mstore(0, res)
            return(0, 0x20)
            }
        }
    }
}