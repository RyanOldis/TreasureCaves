package uk.co.kempt.hannah.data
{
   import com.asliceofcrazypie.geom2d.Grid;
   import virtualworlds.lang.TranslationManager;
   
   public class LevelData
   {
      
      public static const LEVEL_1:String = "eNrt2EtOwlAUgOG9XKMDwoBHGh4jV0ICtYgRmYCJidHNsBNWZozRRCwpODu338ekCZP7p+25bV/T7mFdbdM0dQCAljjsv375lGRSdJwTPqkuKHrUqabIVaebArc1R0XOy7uu09K4X39mUXab0aw8Tvib9Z7p+A+7uTVlXWf6uBjopF2yk7UkMfAt+LnQx6bV5vH2Gbmk/qrK5WE4/LeO82bfYf8S8WJrnHBhTlldwZlTPHDjBXtVlFuvLuEm+8Yc37Svfkbj8aJnsw4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/EPqps38qUrTzfN63U2L+++j1Xy7StM0XBTjajKZDPqj/qhXjJfzctkry0U5HFeD4q5Mbx/lfQnE";
      
      public static const LEVEL_2:String = "eNrt2Etu2lAYgNG19HaGGGASBGXklSAlhCZRXQbNQ6hVvJnupCsLzSSAjXlUVfxb53iSyI7kL9f29fWvtLz6vkjT5VNR9NPd1cNdmqbJaD4f3Xy9vlxk42GWLYZfBqPJ8DK7GE8G2WA+Tv30eF8sHtaH9rrnz+/qFr3o29+IfC1+zOYwKVGiRIkSJUqUKFGiRIkSJUqUKPmnku58AxMUPyhiZ23VVkDEEdw637rP5fu3Vf6p442xLs4zEnudKNzYH/JZuZGV745N0PmgOSN8VHUrw85rB9K2DthzdOyh23qA1Pzahcaysq5Z5XlZRk1rXqwFuf+agxqS3v8oxAVa9+Q/4pUkVuVpr86nbI9l2e7LdveEl+e3xp09Di8UQ1dWDp7NQr3ZdOZTXnVaaMyL8dg8ZqKv2XP4vmpLfu3L9IF37Z1dJz9G29b+MVvbvsp97H+jfXPRehVyzmk/71nmrHbb6o768f7j59Y9HOsG6G2y3TN6tYO5CvWi0Xhz9IKscjb8POYWm73pAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP9b6qfr2zRdPhXFyyuGogC+";
      
      public static const LEVEL_3:String = "eNrt2l1OwkAYRuG1OAYvGi6AgiFcdSUkWIoYERNB0mhkM91JVyahEEEHTP0h/V7OQ9LUxptj63Ra5tXN7ybJzPVcAAAAgP+UZ+U+6n3mCssHWkvMs/vjMbs/pfYu0UNncf+ozvBSHJUZM3ePaDQpFHmHPNNJ3iHc5nieZ81vb072yrYBzeM3XGtZy2i51+TL1pkLU0LJaYZuradFqSi5Z3qCCDrp44NtS60cqStNrEfsXkoRRRUpipQGOq1BmztQFXNk3hdIpchcZGKT6oAYK3MBeuj5T5HkdICpJzOck5wOpaUTm5Ji53FF5/2Axqi9WSWWanbpfUN3sMW7XMRaqa9tNWj4FmKVWN1Z+TP/kzWr289TntXW26tzK/c/rn3sXlbz2v+DXF+vyXvnS4l4zxmu9Ej25U9Q209a/b/Oi+2i+OU0TS3M/op53Mbnm6zVVym7J+ai3LJzkzOK3w9BxhKnebZYb2uH4iKDdYGCfr8fAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAc+Tqbjp4SFxv+jyZ1N3N7XZvPJiNXc+1OvGwO0ra7bjT7o4ao7B7HQ5bSdiJG80wDjvu7R216uNg";
      
      public static const LEVEL_4:String = "eNrt2E1OwkAYBuCzOEYXxAXIn7LiJCRVUYzIQtSQGE/jTTyZxAZDwAhUfjrt83RBgSHhnZl+085beL4f9sehEyoAQAl8fqRHEbIcdYuS5HtgBBFEEEFiXE7mD4kk2nukSMdh+0dpg5c+fB7jH/8nTjfyoZ/qTS2c9mYn0U/t7U78oueLMmnhyvHuivTS1kq++yEtQr35l59atWI8i3HNnhYo11LA9N1J/Lf7SxPw4JEyFLwNfpK7Yrp5lc+4Oix+/XTY4NnXur9aTSbdqd9a5WSHKOsiv0EHrZ4LBwq/z0e1qG6q4ugYnZO/znnY09N/lDsnmf/odjK/luhi2uy2JG8zZYfzfouND7W/trbKeh9XAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAVDgLo+SxHzqjl+HwLFzdzc4GyXgQOqGeNJpJo9+6aF4m7erteVJt3rTq/WZSa9Rr1412eP8CK1W27w==";
      
      public static const LEVEL_10:String = "eNrt2UFOwkAUxvGzOEYWjYuiIMiqJzFhEMSImAiaRmMv4008mYpUStsh026c9/z/mhiom/kYeDNv+mrWt4vpyoxMBAAAAAAAAAAo+XgvXqW325sECzdY/aUhWaccKk0lx1JULYgSYBYFibTVs/8YStHKtD9kfQHb5ZOUsXa8WuI5Ris8msfQFUygd8oXdSHdu3gRoZIk804kvpo4vpYn+iIJWdCuvqhczCqOv8d+VxcoyTIFjWel0gddwD07UG2JXFcSYLQsa9+UOT6S3a0Ai8nBwVRHWzgIrs6vlFhZs6nM3wVVMHcnVe7Pvny3dvsfWGGJPBbeg7mesyC/jl47ioPBAi0fHc86WJjaJsdfMhrO6gzV/l9e4DStNmq1QfbvCWltmmxTZDYBPwmWzq+Z9Ic3LTdlCk64GpzwRcpiPspu1NutAmJ+qc3OWuUVIPeIyRLwr0prsnXwp0WNG3GJC3WDGRMdLfE/L5G3s9w8Fdj8cT/Sl71Tzru6bZsmK46W5zPOBHIDPhRpDHjkGnY3ScrPDPJNxq6cKOmsI9Hyqvd7ZhkBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf8mcmuX4fmpGy6fF4tTYm/zVfLyam5GZXQxjawfWxuexnQ56k+7wctzrX5/1Z7HtxxPz9gnwm4/o";
      
      public static const LEVEL_6:String = "eNrt2ctOwkAYhuF7GaOLhgUIQWTFlTSBWMRYWQiYRuPcDHfClYkoh7a0neGQ/D+8jxtpCpmvc55+mXH/LTLd8SyOa2bUn4xM17SHw/6gfx891QetdqtZf+w8Rp1o2G7Wm51Gu/Ngamb6EkeT5a0BAADnsJin/64hj66c2USFCVOXSu/UGLPiESjMe1Dsna9YeUkrWuhhoe3mG5k2LrrdZjMHfoGDntz2vJi/nixx4XO0onprGG7bYCala82qmW4LUuYLPy2JmCS3cjM6Jtx3YacZyM632zx9VxPbD5Lz5QrtvpwIdkZYgSHzs513zl6S5H9LVMj/x99wmh2WrNP0IXh1X1ysTaV5rQPlCau6q8cySPOmU2XGkmKpz1bVGN2ifupN6rTk1tb9PHYVug6xbtbFfr+oWAVz4UWF0Xa6eC31chlh9g3pylJkir38JzvGKQ+2Pf1KXfxQOTKUTLFJYisW9f4LTSEnJumR/KDjvdRHKyvo/urw25uVnBmpyHrM6ybZ6+V8adYHXcclvNMVOjhpvarJO/aPuNrW9qyVHjVfMP/uKDycWzxt02p1ht/Xa2GopdIC/22FwrOyU0STuahNVi8oD89lZcZy21+sbinua+qiqNhCOTcz/YGU7d0vZdVPTN+Y1up94fg3fosfxQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA52BqZvBsuuNZHH//ABXdhc8=";
      
      public static const LEVEL_7:String = "eNrt211OwkAUQOG1OL41PBQiGHnqSkgQRIwVEgFDNHYz7MSVSR/4a2fKFEty73g+EiWEmDlMKZ1Wvsxs+PZk+rNVmrbMdLiYmr6JR537zl3cje8eeuNJPJzE993eQ+dxPO4M4+5oYlpm+ZI+LbZPjQD8Vz+bwy2omKBykkR9TJblIWvLPGmftf2Yq7LsYQrSj4dWGmx1se9NfLNjvv7QKy37zMQ01S1vvnfjsYaXE5LD3fX+sawiWdoWX9gGne9l5ytw/CeKj2h4y/9sXt0D8noFLrm9Fx+4Fbjjs3Rf3q/kyMoyx5n6PMubPTfIRfsfh1+KDun1H9zr+Fxs4OhB+1QFsQtoZrbmO4KzkqRO1Lal/DTRgd5tmj+8svODDW/FaRvZ6SNhrrNPx9RMY2jVa/cd22GR1ODCgrPOuQLXQkRH9BW2ZKHRx8WRZ86gxL1HFBO5bmz/IzjTd49ca50trO8z7LyLRhpwUqSlaFladp0uvtQE1Thu39VpbLMtJS1Ly7nU8zz1r1RqvNLjV+ozl2rO3VkuOu7HOq8uTdyxOs/WeU7nuYMB8SvNay2j89ss/9FutxUsuOumJZf1CL2GV3vjVtXoN7s33tukgr135VSqi3Ofxqm5L5EY93H4T7eBLens9VbZV5aKp2rUhjS3siGEEEIIIYQQQgghhBBCCLnm8jmYkDBSgvnOYVhfCI1usiycjWxrEAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKBJpmUen01/tkrT718m6Jpf";
      
      public static const LEVEL_8:String = "eNrt2stOwkAYhuF7GYOLhgWCorDqlZhU0qixsvCUBuPcjHfilXmAGKxzLCTMP3kfNloK+T+GOZW+qmV1X6v58rlphurptqkf1VwVAAAgKx/v/x/5JcoiX49g3cMCPo2tkry1Gp6QlbAIa1FznMyibs4cGAPJ6Mz2uJZWbLOIahukusc2/7albk3HxeTqJrOdKyFXj1llfVSLSFf0mDDTHUKD0wV1y8SzbXcjW+GJjo+WYuJGdS0oWo8ZS0Yy8xwuK9ZdYKrwR+clSU0FXZslli6L+KTGLYac/WTPsK43OHwYXw/r/S02b7bSCO2vJip2G3X2gRytCzj21bIKC6IjPqY2ka4bO3W5mjGpAct70cb3OsN5lz+ER0t9YulW9uIs2d3LjhOeP90z4a5r37TSxa7+pIR11Rmaaympbe1VBl5JT31fbdte2YZ9MQv36JJ+T5XQMT31+L6SUsYfZy1fC1DfNqO7SpPSqCHPB+2/jEvxUlbY8EY0P57SHpL+HNX7WDkkOxIHFu1OcrlN0pWhtszjHgpP/d9/Poi+RySrW1yyjZThfVbeJY/gFgodKWXk2d9Gf5eLlAdZsexvhSJy3XJyEh9JF5G/JqRBa1P8Vq+Pu/t5SNByIHgcC/lpJNNwwmegVSbZUtsBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHuihurqWs2Xz00zVDfV442aq3oxqqez02p2cTodn1eT0Ww0XkxG1VldTS9mZ+fq7RM6AMgq";
      
      public static const LEVEL_9:String = "eNrt3UFOAjEUxvGzUHcNCwZFAquexAQYECPCAkyaGOcy3sSTuVCjwpAZ4ojzvv4fGwJsfnntax90hie3u1vNt27sPEGcK15fvj8EOPdCmq8EQYHyxxVArZpRm1vNsQ9S8uxbFExFEbRAYkVBcczFoCZSX4fgtI0jtCVlqMGB83sQnSkjDQ4cxa8NxNoDFVp6KsOuRFhRoDUqSY5x05EhZ9ZUOZns5kuYFmVllUuxIMzbzlhUHYrHd/ByS5hAqlJjeZIFqxUs6qAJVoghaHX83nCkZDKtAmUbFaIUyduOQ9BmIwYynyWqHShQzUX5OVEOH7DUAgIEyNh6hAjRf+2COLoDqxWsKKRiFw7nLJzjL1k3KUypEoEeS2uZqjIVhc2fPFM5j067226QJ0GA2O+lO4OYQCZ3CpAgQWq0RZKFQbPZr+tdkocOHTqKCrhSXojvB8mi3D7SK90yiQMWhgsGKEulXZSVQF+m9HOjwOpVAxakXB/vBDGVWEGEBAkSJEiQIEGCBAkSJEiczDI56phGkCBBggQJEiRIkCCdl2S8TeIeO8wiSJAgQYIECVIqp5MxsRcnTU2R+LtaQyhYsFrEsoyuI7Se2BpG+6O3GqkwR6sMKhcanXL9OVI16f6nL7SQinsBpX80Prixt1VizYW/0xGFqQ3GLLM95VLWme0Bb36GJ4jTwnXdevIwd+P142rVddPbz2fLyXbpxq4/y67yXt7Psnwyy3vDaTa4XIyGo0G+uJ4OZiP3/AbrUY+V";
      
      public static const LEVEL_15:String = "eNrtm+FO2zAQx5+FTPAh4kMDW1XxKU9iibVlTOuwVDoUMc0vszfZk422pMSJY5+dpDlH/18kWmho/bfP57uz+zt5uv+5Tu6efm0218nXb+Wzx/vnx+QuWS7m6+Uqu3+4md8+zGbZ5y+z5cN6MVstFuvV/OY2uU523zfr57dbUwAAAAAAAAAAAICR+fe3/Zqmqoh12WXFIey9peZm53lRKBWtOGKzo1V25TLAqRgoabZFJrK1sVqbJyxVb3hNhBDlj9NDGq266nUZ4Sr3oz5EH9dT+ST3tnPGQznFgIbQsLoOFY/AY7uyLKOri8g23eoiXyfKhmU6dV0BUUCWSSlZ+hhdKl3Rq13u8fGCX4oRaK/eXmzUEKAHiSnzOUoW2b6e8vazetuCfSp3iVqzQ1UyD3i05qncFtBEps44t/zHrvG2sgqjcNV76ul/3qthGQ8NMQel+z1GHFtvxRb/FbDcjqTc298qWo3SZNZFq3YGynPdCxMWKUIxgdPE3jU+3NUeSxTYtN7jo+DhwoKE1j2zfR6IVHBTSmqP6QZJcnaRy/WsXst6r/ASnHrolcQViIVbbluHCXpVWNWJ0VpEWyucd8a3+xYQRttu9Ig9eFhA18EPKijb3ujMphC4Je4Wb8yvhEP/CHOBMgldrxBGVwjyxGBVCSKG5B7xS+X98jeYiK011fAfkp5QSo77Kx3XpNa0VMWywdR1WaacVWAW3vRqA7Ld4FnFN/pHmsuX5avHoyTWXbVeQrtTqekM1aZap1NMsnV0VM89cEp3eFm6dO/RDNAR55kVefGi1N5Lb2l9QOoCQVEmRKEEl+IraRCq3q7iMEz3WiI7Y0A7zvAHm2NgUd6Z+kh940WYem9YL/nSemSNkJr0EEqQsiFn+sgwXLD8g/GIylblx+vgUPakLDukJydfb6zrFGuHvthPn2GmULGrf9ZVh44gfeTBMjSPUfZc+0p2ljliyIX6U/0h3ccUR7P+1H5WZsgGDBEyXajgGM60WetJxd6LcwZMPj3dT99bk5QBp+4rVeal6lygOoymnNb396wJQMSqWJ6PGX5axzpqQthzy/KnWyCHE27BYad01Rcl03KkOcIL8SyScdHVc0x9NTLUSdjmer8vbey7NNPkGFYZYsW1IcLwC0E72+GW/ZZGYxl9qv9yXdvtNsbv9Ip+xjPCLzOLCh0KZZ9iDKIPVb2XU3VPe2YsmuuHOCeQ9tQ2+ieaIEwxRRXp1FRFrMigSUQt52NdSAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYBokf/4DKAMl6g==";
      
      public static const LEVEL_5:String = "eNrt2E1OwkAYBuCzOEYXhg2iRFj1JCYgoMbKBk0Ixl7Gm3gyTfyJwSItZTFTn2dWlIb07TfzTctTmI/up2E4f8zzTrgZLW7CMPQHk9ls0BtMulen56PJdNybnp2f9fqzq25/Mj69CJ3wcJtPF++nngAA/9Lry9doUZRWBFqP07pAmfpEc+l1RkptY7eExVrcRNLuWs7NnxKY383m8uZxHH/6Tdf248i2YqYRcf3o5WXFeHEv3Qo3/+OrVek5RfGwXMaX6m4PMyrKSdm4Ica62OrEqrSjfO+j8c3P361vf9tIrNtjSSdsGnUe/fNAvaJGv0a3tMhlkbU/ZtWilk+GdDLW7jaxt6LabXR7f00h8o73oEjjqeF3ykZ7ZRrzt9mLdslPHsaXNsuK4vOa2vQkVFbWCiFX/yBjkv++bt4GEg5We90llq5dL1f7ypxysj8idrtphttesKOPaD/HQYsCZsmutVUbWwgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALCz0Anj6zCcP+b58xu7QyLE";
      
      public static const TOTAL_NUMBER_OF_LEVELS:int = 15;
      
      public static const LEVEL_13:String = "eNrt3d1O2zAUwPFnwRO7sLgo4yO0V3mSSoEyQOvqC0CKQMvL7E32ZOMCGA116tjp6nPyP7lpKyfKT04cf6V+Ng93y+t7MzOWIIjRxZ/fnzdEiBDFiMpSl2f9k67rzb+p5v0QrlP2xIUDBw4cOGKeqrJN6irfqmpygVU6WNIq4IobTpqbhKpbu7pb8sq7KeiEgQcPXiqvrDUQN50zplxNbi10mGI3mJqYgqijgdYjcXKPaoPi1OV8Si9zNXe3IUOWU4EDDRo0aNCgQYMGbRBae8RBCaz9q3dX5ySx2j30nbuqvcfAgQMHDhw4cNJwkirTGFUYXbxRwJ0YP1algvfQNKVKmncnZFnKOnbBhQsXLlxSXE6pK7IhCgzYLmFrX9Wo1kZruAiBAQPmq3A4pbCE7m9o0IaPA7Uyy+UIDdr/iPmcChaFo5D7TPCIS6+BzZBk2VJ7DuL6EjTvaXKV9h6v9kCbRgm0/wB+puI41mrDrPQvKryBh0CW44VpMWIUYbQQ28QcJiSiTFTm9+Id2CHfioS4d+KTWmHSIct8cy3tqKhQoUKFChWqbXHY7MK1/3a4RtWu/q8F1y5dQy+AlX+Dcnyy8HT7Fc5fQ5/Mn4djlx3Ig3XwtpcvsPZWSB4P08UIVXh1GRUqVKhQ5f0QgwULFixYClkiu+DG+yyOOUcZrhgbMjmyD6nl4JKmLcpBBr/GAFME021dzKG9R103jSxjUK5sYJalPKULO5TNKz7lVHz3twBfWh7+I74uPy6R2I3MfxWh/pPgXVhjRMISSmWSXsPCsW/THmyY2Z/mq/eV9Pc3teWUY+5jMpv7Wgw97+iW7SXvpcTLqdZbVELXMau7s0vwCm217gW10Y1BJ89mAx7rliAUhzkyq+rntZmtHpfLI3N58/bptrq/NTNzelpdnV9Nz6YXi+lx8a2oFt9PJkVVTIqTy8lkUZlffwF5+lZs";
      
      public static const LEVEL_NEW:String = "eNrtz8ERwVAUQNFe3tJkgYSQbhI/EePLBiujGp2ozMqMEjDn3AruLab21EczXXMu4nLI/TmamAEAAAAAAAB8eD7emfm2mePfvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD8kiii20czXXMuYmzPYzRR1cNusR5StWm3aT30y13a9lWZUr1q52XZxf0FctTMbw==";
      
      public static const LEVEL_11:String = "eNrtm19u00AQh8+CUfsQ9SFqkKvmySeJlBSLIkIeaIpWQexluAknIyigFLv2/rFJZibfZ6lpq3U1v53dmZ2x+63YflzXT8W8mAAAAPwvfv7ou2yqUqvrYHxVmZTV9puvKlPrT3WguDK6pyYNDUZcZjT+9UkzmqvUCnNu21Jy+HBeUU7q95q6RdY7RGUyynOg8DRkZsX1eEJfjNtevxQViuUK114Vzk9pzpeyCKPSbnKelhTVw+eIpIFdchslmj/3JOSrGf86+0bee+PTX2M2p9O9UXB2XSyOX4NVxJ9hx9H6SvrWdlcV2ZI2/MSKtJRc69zLgaI7ZYa6YNHVlM7ugyk56k1W3Q0KmK693xW23dkR6DrM99o7l9Gdf6USU0sWlTIzajPDOlMv7+Ur3sUI+aL9QUogT8aeG+RPQ2Y7JWKwFe0+I4yraFF1v7vSIf2fDdAhSVGDbpdincEG5fDNcW1Ub67rlUjMXdtfzbtQTykYXwHL0haabSs+DNk04HQlaqmOmgG1bM6xU/8FeNu1a1sltbC7ynWD1JySN8Gy1ZzmrjMe0hLkvJEWKxOfiDb3m9anYeGgjjJpeN/R0PCVXlGvBxYRaoYccBTUA719sfg/oaAkGKtLoqqN9jayD2ZI8vBKze0Uie1/5TbPQBnSQq8T72s2pdJeKSMHridxsmLbaVG5RZqqEfaYCIdVfd7KtVBmN2xyqpf/5dWDF/1PDsxCXzC7NPmtPHt5K8AHMpn1BdBk8Zvmz4vDN8dfTQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEUNwUm+Xnuphvntfrm+Jx+fRYzIvyYVaWt/Xqfjq7nU7fz8rlw3JV3q3q+/KurKfv9netPhzu+f4L52MHeQ==";
      
      public static const LEVEL_12:String = "eNrt21tOwkAUxvG1OEYfGh+cIAny1JWYIMFLREwUTRPjbIadsDLjFWrbuTSo57T/X19MW+J8zMCcacuzWV7PZw9mbDIAAAAAAPrq7o3+GOvV9tatNOoTVeN0IFYXQ5UzyM8U2b6fJ5WDiQxYauJdk6waX1Wy+s2FTymnWq/2xQf+u9eRZpeDcfcb74C40dAmhIs9Ma9Gz8SNhfadGDHcm1/Uy4/B+79bCPw6OEsn+tu99UjIOpOkQ50iN8pvVQl9y6xhEd3P3N66pijvX1ZPLZzCrvaVPL6aJlwcMbRVp91LG9761r3lQjDb1Hq1tZ+wWM71qAotFNR36Z+KQsmV9ORcuVOUKs8DmTa7Va0z6hur8FZO47UWz3mHwXSiom+39r656aFOUzA5exoS02LPdcoDcT2ZerTdLPJ/Cb93fT9aEWprfbKiUFIyNr4BjV8tym5Mekdp1PVv+ZNI5unF0HsjcTEQu8xLGgJKy+xKD3/2mdx+i+6T6gdU1yqvps3r1U3NPK4vlmsz0YtO1KK00TX0to5+rP/UdVJzcV06qqC78rjpSO315hYpnfqnLkP3CCqnq8+16Easz6d2QuWJwlwJZbCSdE8uKlvChChHtWTfXLAt7XYu1/j8h6fIIoqsKFp/8BD35E0Xs1mr+6cqvmzLr3CZQvoL26T+0pxJ9iMQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAu2GOzGJyOzPjxeN8fmTOL7/+upo8XJmxmVprj+10Ojg5HdnhaHphB7PhcDKa2dPBaHI8MC+vV7rIpg==";
      
      public static const LEVEL_14:String = "eNrtnV9u2kAQxs9SV+3DKA8VoiHlaU9iCRBpqlIsJWlVKcppuAknqxJKYvDa3j9j787wfUQiQTbe38zuzuysCU/F44/N+qGYFwRBEARBztrvzh/KcKQjNWk+CkdS0M30ocApQAEKUETbADRnKQN48uPJNzUNbFPG+XZUs3JeSRijEit0WOW/7It2FWn0FGXoKv8GWXqeSi4Cllis6lwasKrKPvGnDwKcnC6USXk5Yf0fh3MvivjtSSvz4xksJcqBYjOc2p/li2yDtZkzpBjMDKT193Cco+RSvsZQa8r33932kyVgOjjQ6k4prM0R5o5apisYcsy/HStl+wiVGFqtQH29N10axQXs2IHLZgFJBq1pwnZDt09umZOeNLd88Vhrl26cz89hXSuGDxbHAFJPm0aAbOMYjdN6Prsjq1ryUvGvJzvOL9/ETNrVXjfCz/vddr+7f3/BGMNE3XMWQ4275+LDFki83u79kL+vP8Ma4Fjmqr/8gblaUusxve8Yd0kv9G5XD8JP2fB3ZPSseYDXWPK/bHhx6KQ5bZM84womyBA0rh06u0qZ0A5DdQjjHiaqQ3RWZACnw4/RgWsfJAt629F/RtowsHa80b1vO7dZeGVdMzATR85mrRVZaku/h+/uxMduIs0zwKKRfcz3QbBFPsF2iNtA02UJ1mxoKFs4bzwkMMOQ9T8WfpH+J69tIdcQIgg8iL/tGNbMf8Ry+Hj0ROlvRR6XlmTB9tfXA4pbepBdzEHpcC8O2PD3acpiSg5JvzqPyjv+piU26YGdr8wxTVOq+4D8Zqxu/wI329uN44nzXzE4OAjc4PbiDrFD7tQmzNnUt0Wup4cbp7shhTGHFQIyBDe83KIGt18eKg43HJrV4aCWQS1ySF82N3mGMBOBnbzuGVMQdKD+ZByrZZRFF2cqDZ0GOkFDnLOkH/ShHdVWEDfjwxAwBI8hhJZrYIQalkkzIigPuTYP4FrA+/dXNGGq2kuKRCWQSiRlW7/l/h/me9t3/LSrJChnOMfPzOcbOQO3STRTSuiMquC87zFWgeeezYrslaThW180BGjwqYsElNWdFgNSkWxp+5YoEAlFAhCAAHTJoYh00QAnc5yfh5IfQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRCXiqtiu/i1Lubb35vNVbH8fvztbvFwV8yL6Wz6dbK8Wd5Mb1eryerLZHa7WnybXM/W08nserYonv8B73tHXA==";
       
      
      private var _height:int;
      
      private var _width:int;
      
      private var _background:String;
      
      private var _grid:Grid;
      
      private var _name:String;
      
      private var _hash:String;
      
      public function LevelData()
      {
         super();
      }
      
      public static function getName(param1:int) : String
      {
         return TranslationManager.instance.translationData["LEVEL_" + param1.toString() + "_NAME"];
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set grid(param1:Grid) : void
      {
         this._grid = param1;
      }
      
      public function get hash() : String
      {
         return this._hash;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function set width(param1:int) : void
      {
         this._width = param1;
      }
      
      public function set background(param1:String) : void
      {
         this._background = param1;
      }
      
      public function set height(param1:int) : void
      {
         this._height = param1;
      }
      
      public function get width() : int
      {
         return this._width;
      }
      
      public function set hash(param1:String) : void
      {
         this._hash = param1;
      }
      
      public function get height() : int
      {
         return this._height;
      }
      
      public function get grid() : Grid
      {
         return this._grid;
      }
      
      public function get background() : String
      {
         return this._background;
      }
   }
}
