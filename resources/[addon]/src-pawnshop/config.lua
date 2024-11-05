Config = {}

Config.Core = 'qb' -- qb / esx

Config.InventoryHeight = 160

Config.UseTarget = GetConvar('UseTarget', 'true') == 'false'


Config.ImagePath = 'nui://qs-inventory/html/images/'


Config.Pawnsell = {
  coords = vector4(412.13, 315.01, 103.13, 205),
  radius = 2.5,
  ped = 's_m_m_highsec_01'

}

Config.SellLocations = {
  vector3(412.13, 315.01, 103.13),
}

  Config.Location = {
    ["coords"] = vector3(412.13, 315.01, 103.13),
}


Config.Items = {
   ['necklace'] = {
      label = 'Diamanten ketting',
      price = math.random(120,120)
   },
    ['ring'] = {
       label = 'diamond ring',
       price = math.random(100,100)
    },
    ['otfchain'] = {
       label = 'Gangster ketting',
       price = math.random(100,100)
    },
    ['van_necklace'] = {
      label = 'Dure ketting',
      price = math.random(12000,12000)
   },
   ['goldbar'] = {
    label = 'Goudstaaf',
    price = math.random(1000,2000)
    },
    ['camera8'] = {
      label = 'fotocamera',
      price = math.random(500,700)
    },
    ['drone'] = {
    label = 'Drone',
    price = math.random(200,400)
    },
    ['goldchain'] = {
    label = 'Gouden ketting',
    price = math.random(40,60)
    },
    ['polaroid'] = {
      label = 'polaroid',
      price = math.random(200,400)
    },
    ['oldphone'] = {
    label = 'Oude gsm',
    price = math.random(30,70)
    },
    ['laptop7'] = {
    label = 'Laptop',
    price = math.random(400,600)
    },
    ['vrheadset'] = {
      label = 'vrheadset',
      price = math.random(200,400)
    },
    ['tvremote'] = {
    label = 'tvremote',
    price = math.random(5,15)
    },
    ['gameconsole'] = {
      label = 'Game Console',
      price = math.random(70,120)
    },
    ['airpods'] = {
      label = 'airpods',
      price = math.random(100,150)
      },
      ['appletv'] = {
        label = 'appletv',
        price = math.random(300,400)
      },
      ['beats'] = {
      label = 'beats',
      price = math.random(150,175)
      },
      ['macbook'] = {
        label = 'macbook',
        price = math.random(500,600)
      },
      ['ipad'] = {
        label = 'ipad',
        price = math.random(150,175)
        },
        ['watch'] = {
          label = 'watch',
          price = math.random(100,120)
        },
        ['iphone'] = {
          label = 'iphone',
          price = math.random(250,300)
        },
        ['smartphone'] = {
          label = 'smartphone',
          price = math.random(250,300)
        },
      
    
}


Config.Lang = {
   Header = 'Sell Item For',
      sell = {
        text = '[E] - Sell Items',
        icon = 'cart-shopping',
        position = 'right-center',
        style = {
          borderRadius = 0,
          backgroundColor  = 'green',
          color = 'white'
        }
      },
      selldistance = {
        text = 'Sell Items',
        icon = 'hand',
        position = 'right-center',
        style = {
          borderRadius = 0,
          backgroundColor  = 'red',
          color = 'white'
        },
      },
      Dialog = {
       Title = 'Verkoop items',
       label = 'Aantal items',
       description = 'Aantal invullen groter dan 0',
       icon = 'hashtag'
      },
      ErrorSell = {
         id = 'errorr2',
         title = 'ERROR',
         description = 'Er zijn geen items om te verkopen',
         position = 'top-right',
         style = {
             backgroundColor = 'red',
             color = 'white',
             ['.description'] = {
               color = 'white'
             }
         },
         icon = 'xmark',
         iconColor = 'white'
       },
       SellItem = {
         id = 'sellItemid',
         title = 'SUCCES',
         description = 'Je spullen zijn verkocht',
         position = 'top-right',
         style = {
             backgroundColor = 'green',
             color = 'white',
             ['.description'] = {
               color = 'white'
             }
         },
         icon = 'check',
         iconColor = 'white'
       }, 
   }
