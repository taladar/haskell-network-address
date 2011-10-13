module Main where
import Criterion.Main
import Data.Network.Address

ipv4str :: Integral a => a -> String
ipv4str n = "192.168." ++ show (n `div` 255)
                       ++ "."
                       ++ show (n `mod` 255)


ipv4 :: IPv4
ipv4 = toAddress 3232235777

ipv6 :: IPv6
ipv6 = toAddress 42540766452641154071740215577757643572

ipv4subnet :: IPSubnet IPv4
ipv4subnet = IPSubnet ipv4 (toMask (8 :: Int))

ipv6subnet :: IPSubnet IPv6
ipv6subnet = IPSubnet ipv6 (toMask (56 :: Integer))

main = defaultMain
    [ bgroup "IPv4"
        [ bench "readAddress" $ whnf (readAddress :: String -> IPv4) "192.168.1.1"
        , bench "showAddress" $ whnf showAddress ipv4
        ]
    , bgroup "IPv6"
        [ bench "readAddress" $ whnf (readAddress :: String -> IPv6) "2001:0db8:85a3:0:0:8a2e:0370:7334"
        , bench "showAddress" $ whnf showAddress ipv6
        ]
    , bgroup "Subnet"
        [ bgroup "IPv4"
            [ bench "readSubnet" $ whnf (readSubnet :: String -> IPSubnet IPv4) "192.168.1.10/8"
            , bench "showSubnet" $ whnf showSubnet ipv4subnet
            ]
        , bgroup "IPv6"
            [ bench "readSubnet" $ whnf (readSubnet :: String -> IPSubnet IPv6) "2001:0db8:85a3:0:0:8a2e:0370:7334/56"
            , bench "showSubnet" $ whnf showSubnet ipv6subnet
            ]
        ]
    ]

